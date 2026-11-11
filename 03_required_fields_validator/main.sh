#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/required_fields_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/03_required_fields_validator"

SOURCE_DIR="${SOURCE_DIR%/}"
mkdir -p "$(dirname "$OUTPUT")"

find_input_files "$SOURCE_DIR"

{
  echo 'file_name,relative_path,line_number,field,error_type,original_value'
  for file in "${INPUT_FILES[@]}"; do
    awk -v source_dir="$SOURCE_DIR" \
        -v required_fields="$(table_required_fields "$(basename "$file")")" \
        -f "$CSV_AWK" -f "$TASK_DIR/validate_required.awk" \
        "$file"
  done
} > "$OUTPUT"

echo "Отчёт: $OUTPUT"
