#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT="${2:-reports/duplicates_report.csv}"

# TODO: найти полные дубликаты и повторения ключей с различающимися значениями.
# Поддержать ключи из одного или нескольких столбцов.
