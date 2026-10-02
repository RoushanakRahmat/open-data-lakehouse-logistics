-- Replace placeholders before running.
CREATE OR REPLACE EXTERNAL TABLE `PROJECT_ID.lost_cargo_dataset.shipping_manifests`
(
  shipment_id STRING,
  timestamp TIMESTAMP,
  last_ping_lat FLOAT64,
  last_ping_long FLOAT64,
  seal_integrity_status INT64,
  custodian_id STRING OPTIONS(description='Sensitive synthetic custodian identifier.')
)
WITH CONNECTION `PROJECT_ID.REGION.CONNECTION_NAME`
OPTIONS (
  format = 'NEWLINE_DELIMITED_JSON',
  uris = ['gs://BUCKET_NAME/shipping_manifests/*.jsonl']
);
