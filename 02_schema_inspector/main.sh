#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/schema_report.csv}"

# TODO: проверить порядок и количество столбцов, пустые и повторяющиеся заголовки,
# а также различия схем файлов одной таблицы.
