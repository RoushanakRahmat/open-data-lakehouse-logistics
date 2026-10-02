"""Small local test for the tutorial's synthetic log format."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PATTERN = re.compile(
    r"^\[([^]]+)\]\s+\[custodian=([^]]+)\]\s+(.*)$"
)


def main():
    lines = (ROOT / "sample_data" / "maritime_logs.txt").read_text().splitlines()
    parsed = [PATTERN.match(line) for line in lines]
    assert all(parsed), "Every synthetic log line must match the documented format"
    first = parsed[0].groups()
    assert first[1] == "synthetic_user_999"
    assert "Destination: New York" in first[2]
    print("Sample parser test passed")


if __name__ == "__main__":
    main()
