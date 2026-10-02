#!/usr/bin/env bash
set -euo pipefail
: "${PROJECT_ID:?Set PROJECT_ID}"
: "${BUCKET_NAME:?Set BUCKET_NAME}"
echo "Review resource names before deletion."
bq rm -r -f -d "${PROJECT_ID}:lost_cargo_dataset" || true
gcloud storage rm -r "gs://${BUCKET_NAME}" || true
echo "Also review and delete the Iceberg table, namespace, catalog, connection, policies, and temporary IAM bindings."
