#!/usr/bin/env bash

# Входная конфигурация таблиц. Студенты могут подключать её через source config.sh.

table_required_fields() {
  case "$1" in
    customers.csv) echo 'customer_id|email|country|status' ;;
    orders.csv)    echo 'order_id|customer_id|product_id|amount' ;;
    products.csv)  echo 'product_id|name|amount' ;;
    *)             echo '' ;;
  esac
}

table_key_fields() {
  case "$1" in
    customers.csv) echo 'customer_id' ;;
    orders.csv)    echo 'order_id' ;;
    products.csv)  echo 'product_id' ;;
    *)             echo '' ;;
  esac
}

table_id_fields() {
  case "$1" in
    customers.csv) echo 'customer_id' ;;
    orders.csv)    echo 'order_id|customer_id|product_id' ;;
    products.csv)  echo 'product_id' ;;
    *)             echo '' ;;
  esac
}

NULL_MARKERS='|NULL|null|N/A|NA'
EMAIL_FIELDS='email'
COUNTRY_FIELDS='country'
STATUS_FIELDS='status'
