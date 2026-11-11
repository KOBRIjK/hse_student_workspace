BEGIN { required_count = split(required_fields, required, "|") }

FNR == 1 {
    for (i = 1; i <= NF; i++) column[trim($i)] = i
    next
}

{
    for (r = 1; r <= required_count; r++) {
        field = required[r]
        if (!(field in column)) continue

        value = $(column[field])
        if (trim(value) == "")   error = "empty_value"
        else if (is_null(value)) error = "null_value"
        else continue

        print file_name(FILENAME), relative_path(FILENAME), FNR, field, error, value
    }
}
