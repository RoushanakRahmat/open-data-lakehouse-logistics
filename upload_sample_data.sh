#!/usr/bin/env bash
set -euo pipefail
: "${BUCKET_NAME:?Set BUCKET_NAME first}"
gcloud storage cp sample_data/manifests.jsonl "gs://${BUCKET_NAME}/shipping_manifests/manifests.jsonl"
gcloud storage cp sample_data/maritime_logs.txt "gs://${BUCKET_NAME}/raw_logs/maritime_logs.txt"
