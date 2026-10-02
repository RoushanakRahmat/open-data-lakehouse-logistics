#!/usr/bin/env bash
set -euo pipefail
echo "Review resource names before deleting anything."
: "${PROJECT_ID:?Set PROJECT_ID}"
: "${BUCKET_NAME:?Set BUCKET_NAME}"
bq rm -r -f -d "${PROJECT_ID}:lost_cargo_dataset" || true
gcloud storage rm -r "gs://${BUCKET_NAME}" || true
echo "Dataset and bucket cleanup attempted. Delete catalog, namespace, policies, batches, and connections separately after review."
