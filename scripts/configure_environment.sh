#!/usr/bin/env bash
set -euo pipefail
export PROJECT_ID="YOUR_PROJECT_ID"
export REGION="us-central1"
export BUCKET_NAME="${PROJECT_ID}-lost-cargo-lake"
gcloud config set project "${PROJECT_ID}"
gcloud services enable bigquery.googleapis.com biglake.googleapis.com storage.googleapis.com dataplex.googleapis.com datacatalog.googleapis.com dataproc.googleapis.com aiplatform.googleapis.com geminidataanalytics.googleapis.com
echo "APIs enabled. Continue with catalog, namespace, connection, and IAM setup."
