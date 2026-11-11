#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/quality_report.csv}"

# TODO: рассчитать число записей, проблемных строк и процент качества.
# Строку с несколькими ошибками учитывать в problem_records только один раз.
