#!/bin/bash

export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"
export SCRIPT_DIR=$DATA_DIR/scripts
export LOG_DIR=$DATA_DIR/logs

#for better view
function clear_screen() {
    clear
}

# loading screen
function loading(){
    local delay=0.1
    local progress=0
    local width=50
    cols=$(tput cols)
    lines=$(tput lines)
    width=50
    padding=$(( (cols - width) / 2 ))
    vertical_padding=$(( lines / 2 - 2 ))

    for ((i = 0; i < vertical_padding; i++)); do
        echo
    done
    tput setaf 4
    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━ Loading ━━━━━━━━━━━━━━━━━━━━━┓\n"
    printf "%${padding}s┃ " ""
    tput sgr0
    
    while [ $progress -le $width ]; do
        tput setaf $((progress % 2 + 3)) # Cycle between yellow (3) and orange-like (4)
        echo -n "▌"
        sleep $delay
        progress=$((progress + 1))
    done
    tput sgr0 # Reset color
    tput setaf 4
    echo " ┃"
    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
    tput sgr0

    for ((i = 0; i < vertical_padding; i++)); do
        echo
    done
}

function loginmenu(){
    clear_screen
    cols=$(tput cols)
    padding=$(( (cols - 52) / 2 ))
    vertical_padding=$(( lines / 2 - 2 ))

    for ((i = 0; i < vertical_padding; i++)); do
        echo
    done

    tput setaf 4
    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
    printf "%${padding}s┃             WELCOME TO ARCAEA TERMINAL             ┃\n"
    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
    tput sgr0

    printf "%${padding}s1. Login\n"
    printf "%${padding}s2. Register\n"
    printf "%${padding}s3. Exit\n"

    printf "%${padding}s" ""
    read -p "Choose: " choice
    case $choice in
        1)  
            cols=$(tput cols)
            padding=$(( (cols - 52) / 2 ))

            printf "%${padding}s" ""
            read -p "Enter your email: " email

            printf "%${padding}s" ""
            read -p "Enter your password: " password
            output=$($DATA_DIR/login.sh $email $password 2>&1) || {
                cols=$(tput cols)
                padding=$(( (cols - ${#output}) / 2 ))
                printf "%${padding}s" ""
                echo "Error executing login script: $output"
                sleep 3
                loginmenu
                return
            }
                if [[ $output == *"Login Berhasil"* ]]; then
                    clear_screen
                    loading
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))
                        for ((i = 0; i < vertical_padding; i++)); do
                            echo
                        done
                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃                   Login Berhasil!                  ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    clear_screen
                    menu
                elif [[ $output == *"Email belum terdaftar"* ]]; then
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))
                        for ((i = 0; i < vertical_padding; i++)); do
                            echo
                        done
                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃               Email belum terdaftar                ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                elif [[ $output == *"Password Salah"* ]]; then
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))
                        for ((i = 0; i < vertical_padding; i++)); do
                            echo
                        done
                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃             Password Atau Email Salah              ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                else
                    clear_screen
                    loading
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))
                        for ((i = 0; i < vertical_padding; i++)); do
                            echo
                        done
                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃                   Unknown Error                    ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                fi
            ;;
        2)  
            cols=$(tput cols)
            padding=$(( (cols - 52) / 2 ))

            printf "%${padding}s" ""
            read -p "Enter your email: " email_r

            printf "%${padding}s" ""
            read -p "Enter your username: " username_r

            printf "%${padding}s" ""
            read -p "Enter your password: " password_r
            output=$($DATA_DIR/register.sh $email_r $username_r $password_r 2>&1) || {
                if [[ $output == *"Registrasi berhasil"* ]]; then
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))

                    for ((i = 0; i < vertical_padding; i++)); do
                        echo
                    done

                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃                 Register Berhasil!                 ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    clear_screen
                    loginmenu
                elif [[ $output == *"Email sudah terdaftar"* ]]; then
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))

                    for ((i = 0; i < vertical_padding; i++)); do
                        echo
                    done

                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃              Email sudah terdaftar!                ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                elif [[ $output == *"Format email salah"* ]]; then
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))

                    for ((i = 0; i < vertical_padding; i++)); do
                        echo
                    done

                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃              Format email tidak valid!             ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                else
                    clear_screen
                    loading
                    clear_screen
                    cols=$(tput cols)
                    padding=$(( (cols - 52) / 2 ))
                    vertical_padding=$(( lines / 2 - 2 ))

                    for ((i = 0; i < vertical_padding; i++)); do
                        echo
                    done

                    tput setaf 4
                    printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                    printf "%${padding}s┃           Terjadi kesalahan tidak dikenal!         ┃\n"
                    printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                    tput sgr0
                    sleep 3
                    loginmenu
                fi
            }
            ;;
            
        3)
            exit 0
            ;;
        *)
            echo "Invalid choice"
            sleep 2
            loginmenu
            ;;
    esac
}

function menu(){
    while true; do
        clear_screen
        cols=$(tput cols)
        padding=$(( (cols - 52) / 2 ))
        vertical_padding=$(( lines / 2 - 2 ))

        for ((i = 0; i < vertical_padding; i++)); do
            echo
        done

        tput setaf 4
        printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
        printf "%${padding}s┃                   ARCAEA TERMINAL                  ┃\n"
        printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
        tput sgr0
        echo
        printf "%${padding}s1. Add CPU Usage - Core Monitor\n"
        printf "%${padding}s2. Add Memory Usage Monitor\n"
        printf "%${padding}s3. Remove CPU Usage - Core Monitor\n"
        printf "%${padding}s4. Remove Memory Usage Monitor\n"
        printf "%${padding}s5. View All Monitoring Jobs\n"
        printf "%${padding}s6. Exit Terminal\n"
        echo

        printf "%${padding}s" ""
        read -p "Choose [1-6]: " choice
        case $choice in
            1)
                clear_screen
                loading
                $SCRIPT_DIR/manage_core.sh add_core
                clear_screen
                tput setaf 4
                printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                printf "%${padding}s┃                 Perintah Berhasil!                 ┃\n"
                printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                tput sgr0
                sleep 2
                clear_screen
                menu
                ;;
            2)
                clear_screen
                loading
                $SCRIPT_DIR/manage_memory.sh add_memory
                clear_screen
                tput setaf 4
                printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                printf "%${padding}s┃                 Perintah Berhasil!                 ┃\n"
                printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                tput sgr0
                sleep 2
                clear_screen
                menu
                ;;
            3)  
                clear_screen
                loading
                $SCRIPT_DIR/core_usage.sh remove_core
                clear_screen
                tput setaf 4
                printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                printf "%${padding}s┃                 Perintah Berhasil!                 ┃\n"
                printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                tput sgr0
                sleep 2
                clear_screen
                menu
                ;;
            4)  
                clear_screen
                loading
                $SCRIPT_DIR/memory_usage.sh remove_memory
                clear_screen
                tput setaf 4
                printf "%${padding}s┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n"
                printf "%${padding}s┃                 Perintah Berhasil!                 ┃\n"
                printf "%${padding}s┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
                tput sgr0
                sleep 2
                clear_screen
                menu
                ;;
            5)
                loading
                clear_screen
                $SCRIPT_DIR/manager.sh monitor
                sleep 2
                clear_screen
                menu

                ;;
            6)
                exit 0
                ;;
            *)
                echo "Invalid choice"
                sleep 2
                menu
                ;;
        esac
    done
}

clear_screen
loading
loginmenu
