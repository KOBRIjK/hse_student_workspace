FNR == 1 {
    if (FILENAME != required_report && FILENAME != duplicates_report)
        FILES[++file_count] = relative_path(FILENAME)
    next
}

# required_fields_report: file_name,relative_path,line_number,...
FILENAME == required_report {
    REQUIRED[$2]++
    mark_problem($2, $3)
    next
}

# duplicates_report: file_name,relative_path,duplicate_type,key_fields,key_value,occurrences,line_numbers
FILENAME == duplicates_report {
    n = split($7, lines, "|")
    if ($3 == "full_duplicate") {
        for (i = 2; i <= n; i++) {          # первое вхождение не считаем ошибкой
            DUPLICATES[$2]++
            mark_problem($2, lines[i])
        }
    } else {
        for (i = 1; i <= n; i++) {
            CONFLICTS[$2]++
            mark_problem($2, lines[i])
        }
    }
    next
}

{ TOTAL[relative_path(FILENAME)]++ }

END {
    print "file_name,relative_path,total_records,required_errors,full_duplicates,key_conflicts,problem_records,quality_percent"
    for (f = 1; f <= file_count; f++) {
        path = FILES[f]
        total = TOTAL[path] + 0
        problems = PROBLEMS[path] + 0
        percent = total ? sprintf("%.2f", (total - problems) * 100 / total) : "100.00"
        print file_name(path), path, total, REQUIRED[path] + 0, DUPLICATES[path] + 0, \
              CONFLICTS[path] + 0, problems, percent
    }
}

# строка с несколькими ошибками считается один раз
function mark_problem(path, line) {
    if ((path, line) in IS_PROBLEM) return
    IS_PROBLEM[path, line] = 1
    PROBLEMS[path]++
}
