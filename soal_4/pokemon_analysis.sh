#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 pokemon_usage.csv --grep <pokemon_name>"
    echo "       $0 pokemon_usage.csv --filter <pokemon_type>"
    exit 1
fi

FILE="$1"
COMMAND="$2"
SEARCH_TERM="$3"

if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE tidak ditemukan!"
    exit 1
fi

head -n 1 "$FILE"

case "$COMMAND" in
    --grep)
        grep -i "^$SEARCH_TERM" "$FILE" | sort -t, -k2 -r
        ;;
    --filter)
        awk -F',' -v type="$SEARCH_TERM" 'NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)' "$FILE" | sort -t, -k2 -r
        ;;
    *)
        echo "Error: Perintah tidak dikenali!"
        exit 1
        ;;
esac

