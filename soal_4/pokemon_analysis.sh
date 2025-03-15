#!/bin/bash

echo "               __                                 "
echo "______   ____ |  | __ ____   _____   ____   ____  "
echo "\____ \ /  _ \|  |/ _/ __ \ /     \ /  _ \ /    \ "
echo "|  |_> (  <_> |    <\  ___/|  Y Y  (  <_> |   |  \ "
echo "|   __/ \____/|__|_ \\___  |__|_|  /\____/|___|  /"
echo "|__|               \/    \/      \/            \/ "
echo "Options : "
echo "--help"
echo "--info"
echo " Sort by : "
echo " Usage"
echo " RawUsage"
echo " Nama"
echo " HP"
echo " Atk"
echo " Def"
echo " Sp.Atk"
echo " Sp.Def"
echo " Speed"
echo "--grep"
echo "--filter"
echo -n "jawab: "
read jawaban
case "$jawaban" in
 "--help")
echo "--help              Display this help message."
echo "--info              Display the highest adjusted and raw usage."
echo "--sort              Sort the data by the specified colum."
echo "Nama                Sort by Pokemon name"
echo "Usage               Sort by Adjusted Usage."
echo "Raw                 Sort by Adjusted Raw."
echo "HP                  Sort by Adjusted HP."
echo "Atk                 Sort by Adjusted Atk."
echo "Def                 Sort by Adjusted Def."
echo "Sp.Atk              Sort by Adjusted Sp.Atk."
echo "Sp.Def              Sort by Adjusted Sp.Def."
echo "Speed               Sort by Adjusted Speed."
echo "--grep              Search for a specific Pokemon sorted by usage."
echo "--filter            Filter by type of Pokemon sorted by usage."
;;
"--info")
sort -t ',' -k2 -nr pokemon_usage.csv | awk -F ',' 'NR==1 {max=$2} $2 == max {print "Highest Adjusted Usage:",$1,"with",$2}'
sort -t ',' -k3 -nr pokemon_usage.csv | awk -F ',' 'NR==1 {max=$3} $3 == max {print "Highest Raw Usage:",$1,"with",$3}'
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
echo "sort berdasarkan Nama"
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
 #-- Grep --
 echo "sort berdasarkan usage"
 sort -t, -k2 -r pokemon_usage.csv
;;
 "--filter")
 #-- filter --
 echo "sort berdasarkan usage"
 sort -t, -k2 -r pokemon_usage.csv
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

