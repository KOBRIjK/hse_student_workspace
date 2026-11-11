#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/duplicates_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/04_duplicate_detector"

SOURCE_DIR="${SOURCE_DIR%/}"
mkdir -p "$(dirname "$OUTPUT")"

find_input_files "$SOURCE_DIR"

{
  echo 'file_name,relative_path,duplicate_type,key_fields,key_value,occurrences,line_numbers'
  for file in "${INPUT_FILES[@]}"; do
    awk -v source_dir="$SOURCE_DIR" \
        -v key_fields="$(table_key_fields "$(basename "$file")")" \
        -f "$CSV_AWK" -f "$TASK_DIR/find_duplicates.awk" \
        "$file"
  done
} > "$OUTPUT"

echo "Отчёт: $OUTPUT"
