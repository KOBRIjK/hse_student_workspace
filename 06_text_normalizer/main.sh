#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT_DIR="${2:-clean}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/06_text_normalizer"

SOURCE_DIR="${SOURCE_DIR%/}"

find_input_files "$SOURCE_DIR"

for file in "${INPUT_FILES[@]}"; do
  result="$OUTPUT_DIR/${file#"$SOURCE_DIR"/}"
  mkdir -p "$(dirname "$result")"

  awk -v id_fields="$(table_id_fields "$(basename "$file")")" \
      -v email_field="$EMAIL_FIELDS" \
      -v country_field="$COUNTRY_FIELDS" \
      -v status_field="$STATUS_FIELDS" \
      -f "$CSV_AWK" -f "$TASK_DIR/normalize_text.awk" \
      "$file" > "$result"
done

echo "Результат: $OUTPUT_DIR"
