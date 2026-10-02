-- Run as a masked reader without privileged fine-grained access.
SELECT shipment_id, custodian_id
FROM `PROJECT_ID.lost_cargo_dataset.shipping_manifests`
LIMIT 5;
-- Acceptance criterion: shipment_id is visible and custodian_id returns NULL.
