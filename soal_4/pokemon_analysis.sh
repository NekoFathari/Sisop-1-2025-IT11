#!/bin/bash



main_menu() {
    echo -e "\e[33m               __                                 \e[0m"
    echo -e "\e[33m______   ____ |  | __ ____   _____   ____   ____  \e[0m"
    echo -e "\e[33m\\____ \\ /  _ \\|  |/ _/ __ \\ /     \\ /  _ \\ /    \\ \e[0m"
    echo -e "\e[33m|  |_> (  <_> |    <\\  ___/|  Y Y  (  <_> |   |  \\ \e[0m"
    echo -e "\e[33m|   __/ \\____/|__|_ \\\\___  |__|_|  /\\____/|___|  / \e[0m"
    echo -e "\e[33m|__|               \\/    \\/      \\/            \\/ \e[0m"
    echo
    echo -e "\e[34m+-----------------------------------------------+\e[0m"
    echo -e "\e[34m|                   Options                     |\e[0m"
    echo -e "\e[34m+-----------------------------------------------+\e[0m"
    echo -e "\e[34m| --help                                        |\e[0m"
    echo -e "\e[34m| --info                                        |\e[0m"
    echo -e "\e[34m| Sort by:                                      |\e[0m"
    echo -e "\e[34m|     Usage     |   RawUsage   |     Nama       |\e[0m"
    echo -e "\e[34m|     HP        |     Atk      |     Def        |\e[0m"
    echo -e "\e[34m|     Sp.Atk    |    Sp.Def    |     Speed      |\e[0m"
    echo -e "\e[34m| --grep                                        |\e[0m"
    echo -e "\e[34m| --filter                                      |\e[0m"
    echo -e "\e[34m+-----------------------------------------------+\e[0m"
    echo
    echo -n "Enter your choice: "
    read jawaban

    case "$jawaban" in
        "--help")
            echo "--help              Display this help message."
            echo "--info              Display the highest adjusted and raw usage."
            echo "--sort              Sort the data by the specified column."
            echo "Nama                Sort by Pokemon name."
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
            echo "Sorting by Usage..."
            sort -t ',' -k2 -nr pokemon_usage.csv
            ;;
        "RawUsage")
            echo "Sorting by RawUsage..."
            sort -t ',' -k3 -nr pokemon_usage.csv
            ;;
        "Nama")
            echo "Sorting by Nama..."
            sort -t ',' -f -k1 pokemon_usage.csv
            ;;
        "HP")
            echo "Sorting by HP..."
            sort -t ',' -k6 -nr pokemon_usage.csv
            ;;
        "Atk")
            echo "Sorting by Atk..."
            sort -t ',' -k7 -nr pokemon_usage.csv
            ;;
        "Def")
            echo "Sorting by Def..."
            sort -t ',' -k8 -nr pokemon_usage.csv
            ;;
        "Sp.Atk")
            echo "Sorting by Sp.Atk..."
            sort -t ',' -k9 -nr pokemon_usage.csv
            ;;
        "Sp.Def")
            echo "Sorting by Sp.Def..."
            sort -t ',' -k10 -nr pokemon_usage.csv
            ;;
        "Speed")
            echo "Sorting by Speed..."
            sort -t ',' -k11 -nr pokemon_usage.csv
            ;;
        "--grep")
            echo "Sorting by usage with grep..."
            sort -t ',' -k2 -r pokemon_usage.csv
            ;;
        "--filter")
            echo "Sorting by usage with filter..."
            sort -t ',' -k2 -r pokemon_usage.csv
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
}

running_with_param() {
    FILE="$1"
    COMMAND="$2"
    SEARCH_TERM="$3"

    if [ ! -f "$FILE" ]; then
        echo "Error: File $FILE not found!"
        exit 1
    fi

    case "$COMMAND" in
        --grep)
            head -n 1 "$FILE"
            grep -i "^$SEARCH_TERM" "$FILE" | sort -t ',' -k2 -r
            ;;
        --filter)
            head -n 1 "$FILE"
            awk -F',' -v type="$SEARCH_TERM" 'NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)' "$FILE" | sort -t ',' -k2 -r
            ;;
        --info)
            sort -t ',' -k2 -nr "$FILE" | awk -F ',' 'NR==1 {max=$2} $2 == max {print "Highest Adjusted Usage:",$1,"with",$2}'
            sort -t ',' -k3 -nr "$FILE" | awk -F ',' 'NR==1 {max=$3} $3 == max {print "Highest Raw Usage:",$1,"with",$3}'
            ;;
        --sort)
            case "$SEARCH_TERM" in
                "Nama")
                    echo "Sorting by Nama..."
                    sort -t ',' -f -k1 "$FILE"
                    ;;
                "Usage")
                    echo "Sorting by Usage..."
                    sort -t ',' -k2 -nr "$FILE"
                    ;;
                "Raw")
                    echo "Sorting by Raw..."
                    sort -t ',' -k3 -nr "$FILE"
                    ;;
                "HP")
                    echo "Sorting by HP..."
                    sort -t ',' -k6 -nr "$FILE"
                    ;;
                "Atk")
                    echo "Sorting by Atk..."
                    sort -t ',' -k7 -nr "$FILE"
                    ;;
                "Def")
                    echo "Sorting by Def..."
                    sort -t ',' -k8 -nr "$FILE"
                    ;;
                "Sp.Atk")
                    echo "Sorting by Sp.Atk..."
                    sort -t ',' -k9 -nr "$FILE"
                    ;;
                "Sp.Def")
                    echo "Sorting by Sp.Def..."
                    sort -t ',' -k10 -nr "$FILE"
                    ;;
                "Speed")
                    echo "Sorting by Speed..."
                    sort -t ',' -k11 -nr "$FILE"
                    ;;
                *)
                    echo "Error: Unknown sort model!"
                    echo "Usage: $0 pokemon_usage.csv --sort <sort_model>"
                    ;;
            esac
            ;;
            
        *)
            echo -e "\e[31m[Error]\e[0m \e[33mInvalid use of arguments!\e[0m"
            echo "Usage: $0 <file> <command> <search_term>"
            echo "Example: $0 pokemon_usage.csv --sort Usage"
            echo "For more information, use --help or -h"
            exit 1
            ;;
    esac
}

if [ "$#" -eq 0 ]; then
    main_menu
elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
        echo -e "\e[33m                     __                                 \e[0m"
        echo -e "\e[33m      ______   ____ |  | __ ____   _____   ____   ____  \e[0m"
        echo -e "\e[33m      \\____ \\ /  _ \\|  |/ _/ __ \\ /     \\ /  _ \\ /    \\ \e[0m"
        echo -e "\e[33m      |  |_> (  <_> |    <\\  ___/|  Y Y  (  <_> |   |  \\ \e[0m"
        echo -e "\e[33m      |   __/ \\____/|__|_ \\\\___  |__|_|  /\\____/|___|  / \e[0m"
        echo -e "\e[33m      |__|               \\/    \\/      \\/            \\/ \e[0m"
        echo
        echo -e "\e[34m+----------------------+----------------------------------+\e[0m"
        echo -e "\e[34m|        Option        |            Description           |\e[0m"
        echo -e "\e[34m+----------------------+----------------------------------+\e[0m"
        echo -e "\e[34m| --help or -h         | Display this help message.       |\e[0m"
        echo -e "\e[34m| --info               | Display the highest adjusted     |\e[0m"
        echo -e "\e[34m|                      | and raw usage.                   |\e[0m"
        echo -e "\e[34m| --sort               | Sort the data by the specified   |\e[0m"
        echo -e "\e[34m|                      | column.                          |\e[0m"
        echo -e "\e[34m|   Nama               | Sort by Pokemon name.            |\e[0m"
        echo -e "\e[34m|   Usage              | Sort by Adjusted Usage.          |\e[0m"
        echo -e "\e[34m|   Raw                | Sort by Adjusted Raw.            |\e[0m"
        echo -e "\e[34m|   HP                 | Sort by Adjusted HP.             |\e[0m"
        echo -e "\e[34m|   Atk                | Sort by Adjusted Atk.            |\e[0m"
        echo -e "\e[34m|   Def                | Sort by Adjusted Def.            |\e[0m"
        echo -e "\e[34m|   Sp.Atk             | Sort by Adjusted Sp.Atk.         |\e[0m"
        echo -e "\e[34m|   Sp.Def             | Sort by Adjusted Sp.Def.         |\e[0m"
        echo -e "\e[34m|   Speed              | Sort by Adjusted Speed.          |\e[0m"
        echo -e "\e[34m| --grep               | Search for a specific Pokemon    |\e[0m"
        echo -e "\e[34m|                      | sorted by usage.                 |\e[0m"
        echo -e "\e[34m| --filter             | Filter by type of Pokemon        |\e[0m"
        echo -e "\e[34m|                      | sorted by usage.                 |\e[0m"
        echo -e "\e[34m+----------------------+----------------------------------+\e[0m"
        exit 0
elif [ "$#" -eq 3 ]; then
    running_with_param "$1" "$2" "$3"
else
    echo -e "\e[31m[Error]\e[0m \e[33mInvalid use of arguments!\e[0m"
    echo "Usage: $0 <file> <command> <search_term>"
    echo "Example: $0 pokemon_usage.csv --sort Usage"
    echo "For more information, use --help or -h"
    exit 1
fi
