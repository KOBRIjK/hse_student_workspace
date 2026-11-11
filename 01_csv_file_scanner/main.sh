#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/files_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"

SOURCE_DIR="${SOURCE_DIR%/}"
mkdir -p "$(dirname "$OUTPUT")"

find_input_files "$SOURCE_DIR"

{
  echo 'file_name,relative_path,size_bytes,line_count,modified_at'
  for file in "${INPUT_FILES[@]}"; do
    name="$(basename "$file")"
    path="${file#"$SOURCE_DIR"/}"
    size="$(wc -c < "$file" | tr -d ' ')"
    lines="$(awk 'END { print NR }' "$file")"
    modified="$(date -r "$file" '+%Y-%m-%d %H:%M:%S')"
    echo "$name,$path,$size,$lines,$modified"
  done
} > "$OUTPUT"

echo "Найдено файлов: ${#INPUT_FILES[@]}. Отчёт: $OUTPUT"
