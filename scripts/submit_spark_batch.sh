#!/usr/bin/env bash
set -euo pipefail
: "${PROJECT_ID:?Set PROJECT_ID}"
: "${REGION:?Set REGION}"
: "${BUCKET_NAME:?Set BUCKET_NAME}"
gcloud dataproc batches submit pyspark spark/process_maritime_logs.py \
  --project="${PROJECT_ID}" \
  --region="${REGION}" \
  --version=2.3 \
  --deps-bucket="${BUCKET_NAME}" \
  --properties="spark.sql.defaultCatalog=cargo_catalog,spark.sql.catalog.cargo_catalog=org.apache.iceberg.spark.SparkCatalog,spark.sql.catalog.cargo_catalog.type=rest,spark.sql.catalog.cargo_catalog.uri=https://biglake.googleapis.com/iceberg/v1/restcatalog,spark.sql.catalog.cargo_catalog.warehouse=gs://${BUCKET_NAME},spark.sql.catalog.cargo_catalog.header.x-goog-user-project=${PROJECT_ID},spark.sql.catalog.cargo_catalog.rest.auth.type=org.apache.iceberg.gcp.auth.GoogleAuthManager,spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,spark.sql.catalog.cargo_catalog.header.X-Iceberg-Access-Delegation=vended-credentials" \
  -- --input="gs://${BUCKET_NAME}/raw_logs/*.txt"
