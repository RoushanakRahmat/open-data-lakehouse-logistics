SELECT shipment_id, timestamp, last_ping_lat, last_ping_long, custodian_id
FROM `PROJECT_ID.lost_cargo_dataset.shipping_manifests`
WHERE seal_integrity_status = 0
ORDER BY timestamp DESC;
