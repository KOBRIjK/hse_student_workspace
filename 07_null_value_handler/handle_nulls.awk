BEGIN {
    split(required_fields, required, "|")
    for (r in required) IS_REQUIRED[required[r]] = 1
}

FNR == 1 {
    column_count = NF
    for (i = 1; i <= NF; i++) column[i] = trim($i)
    print > cleaned_file
    next
}

{
    for (i = 1; i <= NF; i++)
        if (is_null($i)) {
            MISSING[i]++
            if (!(column[i] in IS_REQUIRED)) $i = ""     # обязательные не трогаем
        }
    print > cleaned_file
}

END {
    for (i = 1; i <= column_count; i++)
        print source_name, source_path, column[i], MISSING[i] + 0
}
