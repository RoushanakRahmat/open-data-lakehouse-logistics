"""Parse maritime text logs and write normalized records to an Iceberg table.

This is an original, minimal template. Adapt regex patterns to your own synthetic data.
"""
import sys
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, explode, regexp_extract, split, trim, to_timestamp

if len(sys.argv) != 2:
    raise SystemExit("Usage: process_maritime_logs.py gs://BUCKET_NAME")

bucket = sys.argv[1].rstrip("/")
catalog = "cargo_catalog"
namespace = "lost_cargo_namespace"
table = "processed_maritime_logs"

spark = SparkSession.builder.appName("governed-logistics-lakehouse").getOrCreate()
raw = spark.read.text(f"{bucket}/raw_logs/*.txt")

# Expected synthetic format: [2026-01-01T12:34:56Z] [custodian=abc] message text
records = raw.select(
    regexp_extract("value", r"^\[([^]]+)\]", 1).alias("timestamp_text"),
    regexp_extract("value", r"\[custodian=([^]]+)\]", 1).alias("custodian_id"),
    regexp_extract("value", r"\]\s*(.*)$", 1).alias("raw_message"),
)

normalized = (
    records
    .withColumn("log_timestamp", to_timestamp("timestamp_text"))
    .withColumn("sentence", explode(split(col("raw_message"), r"(?<=[.!?])\s+")))
    .withColumn("sentence", trim(col("sentence")))
    .filter(col("log_timestamp").isNotNull() & (col("sentence") != ""))
    .select("log_timestamp", "custodian_id", "sentence", "raw_message")
)

(
    normalized.writeTo(f"{catalog}.{namespace}.{table}")
    .using("iceberg")
    .tableProperty("format-version", "2")
    .createOrReplace()
)

spark.stop()
