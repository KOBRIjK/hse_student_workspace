#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/files_report.csv}"

# TODO: рекурсивно найти непустые CSV и создать files_report.csv.
# Столбцы: file_name,relative_path,size_bytes,line_count,modified_at
