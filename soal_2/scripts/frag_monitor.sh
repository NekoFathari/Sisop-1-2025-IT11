#!/bin/bash

export LOG_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2/logs"

function get_frag(){
    local ram_usage
    ram_usage=$(free -m | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}')
    local ram_count
    ram_count=$(free -m | grep Mem | awk '{print $3}')
    local total_ram
    total_ram=$(free -m | grep Mem | awk '{print $2}')
    local available_ram
    available_ram=$(free -m | grep Mem | awk '{print $7}')
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [${ram_usage}%] - Fragment Count [${ram_count} MB] - Details [Total: ${total_ram} MB, Available: ${available_ram} MB]" >> $LOG_DIR/fragment.log
}

get_frag