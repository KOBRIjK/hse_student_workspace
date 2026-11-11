FNR == 1 {
    n++
    NAME[n] = file_name(FILENAME)
    PATH[n] = relative_path(FILENAME)
    COUNT[n] = NF

    split("", seen)
    for (i = 1; i <= NF; i++) {
        column = trim($i)
        COLUMNS[n] = COLUMNS[n] (i > 1 ? "|" : "") column

        if (column == "")        add_issue(n, "empty_header: column " i)
        else if (column in seen) add_issue(n, "duplicate_header: " column)
        seen[column] = 1
    }
}

END {
    for (a = 1; a <= n; a++) {
        for (b = 1; b <= n; b++)
            if (a != b && NAME[a] == NAME[b] && COLUMNS[a] != COLUMNS[b])
                add_issue(a, "schema_mismatch with " PATH[b])

        print NAME[a], PATH[a], COUNT[a], COLUMNS[a], ISSUES[a]
    }
}

function add_issue(n, message) {
    ISSUES[n] = (ISSUES[n] == "" ? message : ISSUES[n] "; " message)
}
