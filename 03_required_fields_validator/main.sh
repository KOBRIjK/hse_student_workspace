#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/required_fields_report.csv}"

# TODO: подключить config.sh и найти пустые обязательные значения.
# В отчёте указать файл, номер строки, поле, тип ошибки и исходное значение.
