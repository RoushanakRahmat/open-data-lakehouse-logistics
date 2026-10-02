"""Parse synthetic maritime logs and write normalized rows to Apache Iceberg."""
import argparse
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, explode, regexp_extract, split, to_timestamp, trim


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, help="GCS input, for example gs://bucket/raw_logs/*.txt")
    parser.add_argument("--table", default="cargo_catalog.lost_cargo_namespace.processed_maritime_logs")
    return parser.parse_args()


def transform(raw):
    parsed = raw.select(
        regexp_extract("value", r"^\[([^]]+)\]", 1).alias("timestamp_text"),
        regexp_extract("value", r"\[custodian=([^]]+)\]", 1).alias("custodian_id"),
        regexp_extract("value", r"\]\s*(.*)$", 1).alias("raw_message"),
    )
    return (
        parsed
        .withColumn("log_timestamp", to_timestamp("timestamp_text"))
        .withColumn("sentence", explode(split(col("raw_message"), r"(?<=[.!?])\s+")))
        .withColumn("sentence", trim(col("sentence")))
        .filter(col("log_timestamp").isNotNull() & (col("sentence") != ""))
        .select("log_timestamp", "custodian_id", "sentence", "raw_message")
    )


def main():
    args = parse_args()
    spark = SparkSession.builder.appName("governed-logistics-lakehouse").getOrCreate()
    normalized = transform(spark.read.text(args.input))
    (
        normalized.writeTo(args.table)
        .using("iceberg")
        .tableProperty("format-version", "2")
        .createOrReplace()
    )
    spark.stop()


if __name__ == "__main__":
    main()
