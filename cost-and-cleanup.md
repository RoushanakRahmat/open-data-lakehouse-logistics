# Cost and cleanup notes

This project can create billable resources. Cost depends on region, storage volume, query volume, Spark execution time, and enabled services.

## Cost controls

- Use a dedicated temporary project when possible.
- Keep synthetic datasets small.
- Inspect query bytes before execution.
- Avoid repeated Spark submissions during debugging.
- Label temporary resources.
- Delete the resources after evidence has been captured.

## Cleanup inventory

- BigQuery dataset and external table
- Cloud Storage bucket and objects
- Dataproc Serverless batch history and temporary dependencies
- Iceberg tables, namespace, and REST catalog
- BigQuery connection
- Knowledge Catalog taxonomy, policy tags, and data policies
- Temporary service accounts or IAM bindings

The provided cleanup script covers only the safest deterministic subset. Review and delete the remaining resources manually to avoid removing unrelated assets.
