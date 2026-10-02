DECLARE origin_city STRING DEFAULT 'London';
SELECT
  log_timestamp AS event_time,
  custodian_id,
  REGEXP_EXTRACT(raw_message, r'Destination:\s*([^.]+)') AS destination_target
FROM `PROJECT_ID.CATALOG_NAME.lost_cargo_namespace.processed_maritime_logs`
WHERE STRPOS(sentence, origin_city) > 0;
