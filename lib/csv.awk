BEGIN {
    FS = OFS = ","
    split(ENVIRON["NULL_MARKERS"], markers, "|")
    for (m in markers) IS_NULL[markers[m]] = 1
}

function trim(text) {
    gsub(/^[ \t]+|[ \t]+$/, "", text)
    return text
}

function is_null(value) {
    return trim(value) in IS_NULL
}

function file_name(path) {
    sub(/.*\//, "", path)
    return path
}

function relative_path(path) {
    return substr(path, length(source_dir) + 2)
}
