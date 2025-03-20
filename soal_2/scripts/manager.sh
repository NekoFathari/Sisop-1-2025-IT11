#!/bin/bash

export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"
export LOG_DIR=$DATA_DIR/logs
export SCRIPT_DIR=$DATA_DIR/scripts


function add_cron_core() {
    local cron_file="/etc/cron.d/core_monitor"
    local script_path=$SCRIPT_DIR/core_monitor.sh
    local cron_schedule="* * * * * root $script_path"
    echo "$cron_schedule" > $cron_file
}

function add_cron_frag() {
    local cron_file="/etc/cron.d/frag_monitor"
    local script_path=$SCRIPT_DIR/frag_monitor.sh
    local cron_schedule="* * * * * root $script_path"
    echo "$cron_schedule" > $cron_file
}

function remove_cron_core() {
    local cron_file="/etc/cron.d/core_monitor"
    rm $cron_file
}

function remove_cron_frag() {
    local cron_file="/etc/cron.d/frag_monitor"
    rm $cron_file
}

function monitoring_all_cron_jobs() {
    no_crontab_count=0
    total_users=0

    while true; do
        for user in $(cut -f1 -d: /etc/passwd); do
            crontab -u $user -l 2>/dev/null > /dev/null
            if [ $? -eq 0 ]; then
                echo "Cron jobs for user: $user"
                crontab -u $user -l
                echo "-------------------------"
            else
                no_crontab_count=$((no_crontab_count + 1))
            fi
            total_users=$((total_users + 1))
        done

        if [ $no_crontab_count -eq $total_users ]; then
            echo "Tidak ada crontab yang sedang berjalan"
        elif [ $((total_users - no_crontab_count)) -eq 1 ]; then
            for user in $(cut -f1 -d: /etc/passwd); do
            crontab -u $user -l 2>/dev/null > /dev/null
            if [ $? -eq 0 ]; then
                echo "User: $user"
                echo "Program yang berjalan:"
                crontab -u $user -l
                break
            fi
            done
        fi

        # Prompt to exit the loop
        echo "Press Q to quit or any other key to refresh..."
        read -t 5 -n 1 key
        if [[ $key == "Q" || $key == "q" ]]; then
            echo
            echo -n "Exiting monitoring..."
            break
        fi

        # Clear the screen for the next iteration
        sleep 1
        clear
    done
}

function option(){
    parm=$1
    case $parm in
        "add_core")
            add_cron_core
            ;;
        "add_frag")
            add_cron_frag
            ;;
        "remove_core")
            remove_cron_core
            ;;
        "remove_frag")
            remove_cron_frag
            ;;
        "monitor")
            monitoring_all_cron_jobs
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

option $1
