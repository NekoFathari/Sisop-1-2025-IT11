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
	title "Money Rain"
		symbols=( "$" "€" "£" "¥" "₫" "₹" "฿" "₣" )
		cols=$(tput cols)
		rows=$(tput lines)
		declare -a rain

		for ((i=0; i<$cols; i++)); do
		rain[$i]=$(( RANDOM % rows ))
		done

		while true; do
    		clear
    		for ((row=0; row<$rows; row++)); do
        	for ((col=0; col<$cols; col++)); do
            if [[ ${rain[$col]} -eq $row ]]; then
                printf "\e[31m%s\e[0m" "${symbols[RANDOM % ${#symbols[@]}]}"
            else
                printf " "
            fi
        done
        echo ""
    done

    	for ((i=0; i<$cols; i++)); do
        ((rain[$i]++))
        if (( rain[$i] > rows )); then
            rain[$i]=0
        fi
    done

    sleep 0.2
	done
	    ;;

        "Brain Damage")
            title "Brain Damage"
 		while true; do
		clear
	echo -e "\e[31m================ Waktu ================\e[0m"
 	echo -e "Time: $(date)"

	echo -e "\e[35m~~~~~~~~~~~~~~~~ Penggunaan Dalam CPU ~~~~~~~~~~~~~~~~\e[0m"
	top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'

	echo -e "\e[36m---------------- Penggunaan Dalam Memori ----------------\e[0m"
	free -h | awk 'NR==2{printf "Total: %s, Used: %s, Free: %s\n", $2, $3, $4}'

	echo -e "\e[35m************* Daftar Process *************\e[0m"
	printf "| %-8s | %-10s | %-6s | %-6s | %-20s |\n" "PID" "USER" "%CPU" "%MEM" "COMMAND"
	echo "|----------|------------|--------|--------|----------------------|"
	ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -11 | awk '{printf "| %-8s | %-10s | %-6s | %-6s | %-20s |\n", $1, $2, $3, $4, $5}'

	sleep 1
	done
        ;;

        *)
		echo "Sayang sekali lagu anda tidak dikenali. Silakan pilih lagu yang telah disediakan: Speak to Me, On the Run, Time, Money, Brain Damage."
            	exit 1
       ;;
    esac
}

play_track "$TRACK"

