#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/schema_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/02_schema_inspector"


SOURCE_DIR="${SOURCE_DIR%/}"
mkdir -p "$(dirname "$OUTPUT")"

find_input_files "$SOURCE_DIR"

{
  echo 'file_name,relative_path,column_count,columns,issues'
  if [ "${#INPUT_FILES[@]}" -gt 0 ]; then
    awk -v source_dir="$SOURCE_DIR" \
        -f "$CSV_AWK" -f "$TASK_DIR/inspect_schema.awk" \
        "${INPUT_FILES[@]}"
  fi
} > "$OUTPUT"

echo "Проверено файлов: ${#INPUT_FILES[@]}. Отчёт: $OUTPUT"
