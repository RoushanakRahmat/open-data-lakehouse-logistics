# Contributing

Contributions are welcome when they improve clarity, reproducibility, governance, or safety.

## Before opening a pull request

1. Do not include credentials, access tokens, project identifiers, or billing details.
2. Use synthetic data only.
3. Keep product-specific commands parameterized.
4. Run `make check`.
5. Explain what changed and how it was tested.

## Style

- SQL files use descriptive names and comments for placeholders.
- Python follows standard PEP 8 conventions.
- Shell scripts use `set -euo pipefail`.
- Documentation distinguishes demonstrated behavior from production recommendations.
