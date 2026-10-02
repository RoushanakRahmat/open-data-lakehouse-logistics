-- Run as a principal that has masked-reader access but not fine-grained reader access.
SELECT shipment_id, custodian_id
FROM `lost_cargo_dataset.shipping_manifests`
LIMIT 5;
-- Expected: shipment_id is visible and custodian_id is NULL.
