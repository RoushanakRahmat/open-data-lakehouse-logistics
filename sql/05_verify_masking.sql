SELECT shipment_id, custodian_id
FROM `PROJECT_ID.lost_cargo_dataset.shipping_manifests`
LIMIT 5;
-- Expected for a masked reader: shipment_id is visible and custodian_id is NULL.
