#!/bin/bash

export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"

# check email apakah sudah terdaftar pada data karena harus unik
function check_format_email(){
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

function check_email() {
    local email=$1
    if grep -q "$email" $DATA_DIR/data/player.csv; then
        echo "Email sudah terdaftar"
        return 1 # Email sudah dipake
    else
        return 0 # Email belum dipake
    fi
}

function check_password(){
    local password=$1
    if [[ ${#password} -ge 8 && "$password" =~ [a-z] && "$password" =~ [A-Z] && "$password" =~ [0-9] ]]; then
        return 0
    else
        return 1
    fi
}

function encrypt_password() {
    local password=$1
    local salt="uwaw"
    local encrypted_password=$(echo -n $password$salt | sha256sum | awk '{print $1}')
    echo $encrypted_password
}

function register() {
    local email=$1
    local username=$2
    local password=$3

    if [ -z "$email" ]; then
        echo "Harap Masukan email"
        exit 1
    fi

    if check_format_email $email; then
        if ! check_email $email; then
            exit 1
        fi
    else
        echo "Format email salah"
        exit 1
    fi

    # check username ada tidak
    if [ -z "$username" ]; then
        echo "Harap Masukan Username"
        exit 1
    fi

    # check password ada tidak
    if [ -z "$password" ]; then
        echo "Harap Masukan Password"
        exit 1
    else 
        if check_password $password; then
            echo "Password format is correct"
        else
            echo "Password harus memiliki minimal 8 karakter, terdapat huruf besar, huruf kecil, dan angka"
            exit 1
        fi
    fi

    local encrypted_password=$(encrypt_password $password)
    echo "$email,$username,$encrypted_password" >> $DATA_DIR/player.csv
    echo "Registrasi berhasil"
}

register $1 $2 $3
