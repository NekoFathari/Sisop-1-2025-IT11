#!/bin/bash


clear
echo ""
echo -e "\e[1;35m   Selamat Datang Gais^-^   \e[0m"
echo ""


if [[ "$1" == --play=* ]]; then
    TRACK="${1#--play=}"
else
    echo "Menggunakan metode ./dsotm.sh --play=\"<Track>\""
    exit 1
fi


title() {
    echo -e "\e[1;34m============================\e[0m"
    echo "............................"
    echo -e "\e[1;31m  PLAYING NOW: $1 \e[0m"
    echo  "............................"
    echo -e "\e[1;34m============================\e[0m"
}

play_track() {
    case "$1" in
        "Speak to Me")
            title "Speak to Me"
                curl -s https://raw.githubusercontent.com/annthurium/affirmations/refs/heads/main/affirmations.js | sed '1d;$d' |  sed -E 's/^[[:space:]]*"//;s/",?$//;' | grep -v '^\];$' | while IFS= read -r line; do
		echo "$line"
                sleep 1
	done
	    ;;
        "On the Run")
            title "On the Run"
            progress=0
            while [ $progress -lt 100 ]; do
                progress=$((progress + RANDOM % 10))
                [ $progress -gt 100 ] && progress=100
                echo -ne "\rTunggu ya..: [$(printf '#%.0s' $(seq 1 $((progress / 2))))$(printf ' %.0s' $(seq 1 $((50 - progress / 2))))] $progress%"
                sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
            done
	    echo ""
            echo -e "\e[1;36m TERSELESAIKAN!^-^\e[0m"
            ;;
        "Time")
            title "Time"
            while true; do
            echo -ne "\r----- \e[1;33m$(date '+%A | %Y-%m-%d | %H:%M:%S') -----\e[0m"
                sleep 1
            done
            ;;
        "Money")
            title "Money"
            symbols=( "$" "€" "£" "¥" "¢" "₹" "₩" "฿" "₣" )
            while true; do
                clear
                for i in {1..20}; do
                    for j in {1..40}; do
                        printf "%s" "${symbols[RANDOM % ${#symbols[@]}]} "
                    done
                    echo ""
                done
                sleep 0.1
            done
            ;;
        "Brain Damage")
            title "Brain Damage"
            while true; do
                ps aux --sort=-%mem | head -10
                sleep 1
            done
            ;;
        *)
            echo "Track tidak dikenali. Silakan pilih dari: Speak to Me, On the Run, Time, Money, Brain Damage."
            exit 1
            ;;
    esac
}

play_track "$TRACK"

