#!/bin/bash
export LOG_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2/logs"

function get_core() {
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}') 
    local cpu_info
    cpu_info=$(lscpu | grep "Model name" | sed "s/.*: //" | awk '{$1=$1; print}')
    local date=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$date] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_info]" >> $LOG_DIR/core.log
}

get_core