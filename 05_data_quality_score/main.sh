#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/quality_report.csv}"

source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
TASK_DIR="$PROJECT_ROOT/05_data_quality_score"

SOURCE_DIR="${SOURCE_DIR%/}"
REPORTS_DIR="$(dirname "$OUTPUT")"
REQUIRED_REPORT="$REPORTS_DIR/required_fields_report.csv"
DUPLICATES_REPORT="$REPORTS_DIR/duplicates_report.csv"

# результаты предыдущих проверок
bash "$PROJECT_ROOT/03_required_fields_validator/main.sh" "$SOURCE_DIR" "$REQUIRED_REPORT" > /dev/null
bash "$PROJECT_ROOT/04_duplicate_detector/main.sh" "$SOURCE_DIR" "$DUPLICATES_REPORT" > /dev/null

find_input_files "$SOURCE_DIR"

awk -v source_dir="$SOURCE_DIR" \
    -v required_report="$REQUIRED_REPORT" \
    -v duplicates_report="$DUPLICATES_REPORT" \
    -f "$CSV_AWK" -f "$TASK_DIR/calculate_quality.awk" \
    "$REQUIRED_REPORT" "$DUPLICATES_REPORT" "${INPUT_FILES[@]}" > "$OUTPUT"

echo "Отчёт: $OUTPUT"
