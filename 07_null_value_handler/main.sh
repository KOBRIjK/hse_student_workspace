#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT_DIR="${2:-clean}"
REPORT="${3:-reports/null_report.csv}"

# TODO: стандартизировать маркеры NULL без подстановки вымышленных значений.
# Сохранить очищенные CSV и количество пропусков по каждому столбцу.
