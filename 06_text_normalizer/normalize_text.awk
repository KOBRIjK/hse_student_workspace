BEGIN {
    split(id_fields, ids, "|")
    for (i in ids) IS_ID[ids[i]] = 1

    COUNTRIES["ru"] = COUNTRIES["russia"] = COUNTRIES["россия"] = COUNTRIES["Россия"] = "RU"
    COUNTRIES["us"] = COUNTRIES["usa"] = COUNTRIES["сша"] = COUNTRIES["США"] = "US"

    STATUSES["active"] = STATUSES["активен"] = STATUSES["Активен"] = "active"
    STATUSES["inactive"] = STATUSES["неактивен"] = STATUSES["Неактивен"] = "inactive"
    STATUSES["pending"] = STATUSES["ожидает"] = STATUSES["Ожидает"] = "pending"
}

FNR == 1 {
    for (i = 1; i <= NF; i++) column[i] = $i = trim($i)
    print
    next
}

{
    for (i = 1; i <= NF; i++) {
        if (column[i] in IS_ID) continue

        $i = trim($i)
        value = tolower($i)

        if (column[i] == email_field)                              $i = value
        else if (column[i] == country_field && value in COUNTRIES) $i = COUNTRIES[value]
        else if (column[i] == status_field && value in STATUSES)   $i = STATUSES[value]
    }
    print
}
