-- Replace REGION, CONNECTION_NAME, PROJECT_ID, and bucket path before running.
CREATE OR REPLACE EXTERNAL TABLE `lost_cargo_dataset.shipping_manifests`
(
  shipment_id STRING,
  event_timestamp TIMESTAMP,
  last_ping_lat FLOAT64,
  last_ping_long FLOAT64,
  seal_integrity_status INT64,
  custodian_id STRING OPTIONS(description='Sensitive identifier for the cargo custodian.')
)
WITH CONNECTION `REGION.CONNECTION_NAME`
OPTIONS (
  format = 'NEWLINE_DELIMITED_JSON',
  uris = ['gs://PROJECT_ID-lost-cargo-lake/shipping_manifests/*.jsonl']
);
