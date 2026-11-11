#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT_DIR="${2:-clean}"
REPORT="${3:-reports/null_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/07_null_value_handler"

SOURCE_DIR="${SOURCE_DIR%/}"
mkdir -p "$(dirname "$REPORT")"

find_input_files "$SOURCE_DIR"

{
  echo 'file_name,relative_path,column,missing_count'
  for file in "${INPUT_FILES[@]}"; do
    path="${file#"$SOURCE_DIR"/}"
    result="$OUTPUT_DIR/$path"
    mkdir -p "$(dirname "$result")"

    input="$file"
    [ -f "$result" ] && input="$result"

    temp_file="$(mktemp)"
    awk -v source_name="$(basename "$file")" \
        -v source_path="$path" \
        -v cleaned_file="$temp_file" \
        -v required_fields="$(table_required_fields "$(basename "$file")")" \
        -f "$CSV_AWK" -f "$TASK_DIR/handle_nulls.awk" \
        "$input"
    mv "$temp_file" "$result"
  done
} > "$REPORT"

echo "Результат: $OUTPUT_DIR, отчёт: $REPORT"
