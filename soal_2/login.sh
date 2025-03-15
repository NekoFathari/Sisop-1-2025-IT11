#!/bin/bash

export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"

function login() {
    local email=$1
    local password=$2

    if [ -z "$email" ]; then
        echo "Harap Masukan email"
        exit 1
    fi

    if [ -z "$password" ]; then
        echo "Harap Masukan password"
        exit 1
    fi

    if grep -q "$email" $DATA_DIR/data/player.csv; then
        local password=$2
        local encrypted_password=$(awk -F, -v email=$email '$1 == email {print $3}' $DATA_DIR/player.csv)
        local salt="uwaw"
        local type_password=$(echo -n $password$salt | sha256sum | awk '{print $1}')
        if [ "$encrypted_password" == "$type_password" ]; then
            echo "Login Berhasil"
        else
            echo "Password Salah"
        fi
    else
        echo "Email belum terdaftar"
    fi

}
login $1 $2