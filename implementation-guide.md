# Implementation guide

## 1. Prepare the project

Set `PROJECT_ID`, `REGION`, and `BUCKET_NAME`, then run `scripts/configure_environment.sh` after reviewing it.

## 2. Create the storage layout

Create these prefixes in the project bucket:

```text
shipping_manifests/
raw_logs/
```

Upload the synthetic files from `sample_data/` or use your own non-sensitive equivalent.

## 3. Create the BigLake external table

Edit and run `sql/01_create_external_table.sql`. The BigQuery connection and bucket must be configured in compatible locations, and the connection service account requires appropriate access to the bucket.

Run `sql/02_find_compromised_shipments.sql` to verify the manifest path.

## 4. Create the Iceberg catalog and namespace

Provision a Lakehouse Iceberg REST Catalog and create the `lost_cargo_namespace` namespace. Record the exact catalog name and region. Do not assume the display name and SQL resource path are identical.

## 5. Submit the Spark transformation

Review the regular expressions in `spark/process_maritime_logs.py`. Export the variables required by `scripts/submit_spark_batch.sh`, then submit the batch from the repository root.

## 6. Query the processed table

Update the table path in `sql/03_preview_iceberg_logs.sql`. Run the query and confirm that timestamps, identifiers, sentences, and raw messages are present.

Run `sql/04_extract_destination.sql` after adjusting the origin value to match the synthetic data.

## 7. Configure metadata and AI-assisted exploration

Generate and review table and column descriptions before publishing them. Use Conversational Analytics only after confirming that the selected table, user permissions, and masking behavior are correct.

## 8. Apply the masking control

Create a taxonomy and policy tag for the sensitive identifier. Configure a nullification masking rule, assign the tag to `custodian_id`, and test using an identity that has masked-reader access without privileged fine-grained access.

Run `sql/05_verify_masking.sql`. The acceptance criterion is simple: `shipment_id` remains visible and `custodian_id` returns `NULL`.

## 9. Capture evidence

Use `screenshots/README.md`. Redact project IDs, account details, tokens, and billing information.

## 10. Clean up

Review `scripts/cleanup.sh`. Delete the BigQuery dataset, Cloud Storage objects, Spark batches, catalog tables, namespace, catalog, connection, policy tags, and any temporary IAM bindings that are no longer required.
