SELECT log_timestamp, custodian_id, sentence, raw_message
FROM `PROJECT_ID.CATALOG_NAME.lost_cargo_namespace.processed_maritime_logs`
ORDER BY log_timestamp
LIMIT 20;
