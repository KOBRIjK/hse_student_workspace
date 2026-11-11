#!/usr/bin/env bash

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CSV_AWK="$PROJECT_ROOT/lib/csv.awk"

export LC_ALL=C
source "$PROJECT_ROOT/config.sh"
export NULL_MARKERS

# Непустые CSV-файлы каталога $1 (без clean/ и reports/) -> массив INPUT_FILES
find_input_files() {
  INPUT_FILES=()
  while IFS= read -r file; do
    INPUT_FILES+=("$file")
  done < <(find "$1" -type f -name '*.csv' -size +0 ! -path '*/clean/*' ! -path '*/reports/*' | sort)
}
