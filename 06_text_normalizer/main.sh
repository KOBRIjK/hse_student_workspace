#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-data/raw}"
OUTPUT_DIR="${2:-clean}"

# TODO: убрать лишние пробелы, привести email к нижнему регистру,
# стандартизировать страны и статусы. Идентификаторы изменять нельзя.
