# Governance validation runbook

## Objective

Verify that users can investigate shipments without seeing the sensitive custodian identifier.

## Control

- Classification: sensitive operational identifier
- Protected column: `custodian_id`
- Enforcement: policy tag plus data masking rule
- Masking behavior: nullification for masked readers

## Test identities

Use separate test identities or controlled impersonation:

1. Privileged reviewer with fine-grained access
2. Masked reader without fine-grained access
3. User without table access

## Expected results

- Privileged reviewer: can access the unmasked value if explicitly authorized.
- Masked reader: can query permitted columns, while `custodian_id` returns `NULL`.
- Unauthorized user: cannot query the protected table.

## Evidence to retain

- Policy tag and policy configuration
- IAM bindings used for the test
- Query text
- Redacted query results
- Test date and reviewer

## Failure response

If a masked reader sees the raw value, stop publication, remove access, inspect policy-tag assignment and IAM bindings, repeat the test, and document the correction.
