BEGIN { key_size = split(key_fields, key_columns, "|") }

FNR == 1 {
    for (i = 1; i <= NF; i++) column[trim($i)] = i
    next
}

{
    key = ""
    for (k = 1; k <= key_size; k++)
        key = key (k > 1 ? "|" : "") trim($(column[key_columns[k]]))

    # одинаковые строки целиком
    if (!ROW_TIMES[$0]++) ROWS[++row_count] = $0
    ROW_LINES[$0] = ROW_LINES[$0] (ROW_TIMES[$0] > 1 ? "|" : "") FNR
    ROW_KEY[$0] = key

    # одинаковый ключ
    if (!KEY_TIMES[key]++) KEYS[++key_count] = key
    KEY_LINES[key] = KEY_LINES[key] (KEY_TIMES[key] > 1 ? "|" : "") FNR
    if (!((key, $0) in SEEN)) {
        SEEN[key, $0] = 1
        KEY_VARIANTS[key]++
    }
}

END {
    for (i = 1; i <= row_count; i++) {
        row = ROWS[i]
        if (ROW_TIMES[row] > 1)
            report("full_duplicate", ROW_KEY[row], ROW_TIMES[row], ROW_LINES[row])
    }
    for (i = 1; i <= key_count; i++) {
        key = KEYS[i]
        if (KEY_VARIANTS[key] > 1)
            report("key_conflict", key, KEY_TIMES[key], KEY_LINES[key])
    }
}

function report(type, key, times, lines) {
    print file_name(FILENAME), relative_path(FILENAME), type, key_fields, key, times, lines
}
