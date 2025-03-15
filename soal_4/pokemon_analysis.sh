#!/bin/bash
;;
 "Usage")
  # -- Usage --
echo "sort berdasarkan usage"
sort -t ',' -k2 -nr pokemon_usage.csv
;;
 "RawUsage")
  # -- RawUsage --
echo "sort berdasarkan RawUsage"
sort -t ',' -k3 -nr pokemon_usage.csv
;;
 "Nama")
  # -- Nama --
echo "sort berdasarkan RawUsage"
sort -t ',' -f -k1  pokemon_usage.csv
;;
 "HP")
  # -- HP --
echo "sort berdasarkan HP"
sort -t ',' -k6 -nr pokemon_usage.csv
;;
 "Atk")
 # -- Atk --
echo " sort berdasarkan Atk "
sort -t ',' -k7 -nr pokemon_usage.csv
;;
 "Def")
 # -- Def --
echo "sort berdasarkan Def "
sort -t ',' -k8 -nr pokemon_usage.csv
;;
 "Sp.Atk")
 # -- Sp.Atk --
echo "sort berdasarkan Sp.Atk"
sort -t ',' -k9 -nr pokemon_usage.csv
;;
 "Sp.Def")
 # -- Sp.Def --
echo "sort berdasarkan Sp.Def"
sort -t ',' -k10 -nr pokemon_usage.csv
;;
 "Speed")
 #-- Speed --
echo  "sort berdasarkan speed "
sort -t ',' -k11 -nr pokemon_usage.csv
;;
 "--grep")
;;
 "--filter")
;;
esac




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

