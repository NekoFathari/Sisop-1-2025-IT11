#!/bin/bash

# Membersihkan terminal
clear

# Memeriksa argumen yang diberikan
if [[ "$1" == --play=* ]]; then
    TRACK="${1#--play=}"
else
    echo "Usage: ./dsotm.sh --play=\"<Track>\""
    exit 1
fi

# Fungsi untuk menampilkan informasi tentang lagu
title() {
    echo "===================================="
    echo "...................................."
    echo "  Lagu diputar: $1"
    echo "...................................."
    echo "===================================="
}

play_track() {
    case "$1" in
        "Speak to Me")
            title "Speak to Me"
            while true; do
                curl -s https://www.affirmations.dev | jq -r '.affirmation'
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
            echo "TERSELESAIKAN!^-^"
            ;;
        "Time")
            title "Time"
            while true; do
                date '+%Y-%m-%d %H:%M:%S'
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

# Menjalankan fungsi play_track
play_track "$TRACK"

