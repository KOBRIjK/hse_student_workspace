## Структура

```text
student_workspace/
├── 01_csv_file_scanner/main.sh
├── 02_schema_inspector/main.sh
├── 03_required_fields_validator/main.sh
├── 04_duplicate_detector/main.sh
├── 05_data_quality_score/main.sh
├── 06_text_normalizer/main.sh
├── 07_null_value_handler/main.sh
├── config.sh
├── data/raw/
│   ├── customers.csv
│   ├── archive/customers.csv
│   ├── catalog/products.csv
│   └── sales/orders.csv
├── clean/                    # сюда записываются очищенные CSV
└── reports/                  # сюда записываются отчёты
```

## Правила

- Все задания выполняются на Bash с использованием стандартных Unix-утилит.
- Исходные файлы в `data/raw/` изменять нельзя.
- Скрипты должны корректно обрабатывать вложенные каталоги.
- Файлы из `clean/` и `reports/` не должны попадать во входной набор.
- Первая строка CSV считается заголовком; номера строк в ошибках должны
  соответствовать исходному файлу.
- Настройки обязательных, ключевых и неизменяемых полей находятся в `config.sh`.

## Задания и результаты

1. `CSV File Scanner` → `reports/files_report.csv`
2. `Schema Inspector` → `reports/schema_report.csv`
3. `Required Fields Validator` → `reports/required_fields_report.csv`
4. `Duplicate Detector` → `reports/duplicates_report.csv`
5. `Data Quality Score` → `reports/quality_report.csv`
6. `Text Normalizer` → нормализованные файлы в `clean/`
7. `Null Value Handler` → очищенные файлы в `clean/` и `reports/null_report.csv`

Каждый скрипт запускается из корня `student_workspace`, например:

```bash
bash 01_csv_file_scanner/main.sh
```
