
# Sisop-1-2025-IT10

# Member

    1. Muhammad Ardiansyah Tri Wibowo - 5027241091
    2. Erlinda Annisa Zahra Kusuma - 5027241108
    3. Fika Arka Nuriyah - 5027241071


# Reporting
#### SOAL 1

<ISINYA>

#### SOAL 2

Dalam soal ini terdapat 9 Step yang harus kita penuhi untuk soal ini selesai yaitu:

    1. “First Step in a New World”
    2. “Radiant Genesis”
    3. “Unceasing Spirit”
    4. “The Eternal Realm of Light”
    5. “The Brutality of Glass”
    6. “In Grief and Great Delight”
    7. “On Fate's Approach”
    8. “The Disfigured Flow of Time”
    9. “Irruption of New Color”

untuk menjalan program ini diperlukan berada di ```terminal.sh```

1. **“First Step in a New World”**

pada step ini kita harus membuat ```register.sh``` dan ```login.sh``` dengan parameter yang sudah di tentukan.

#### register.sh
    export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"

    function register() {
        # deklarasi variabel
        local email=$1
        local username=$2
        local password=$3
        .....
        echo "$email,$username,$encrypted_password" >> $DATA_DIR/data/player.csv
        .....
    }

    register $1 $2 $3    

#### login.sh
    export DATA_DIR="/home/fathari/ITS/Code/SISOP/MODUL_1/soal_2"

    function login(){
        #deklarasi variabel
        local email=$1
        local passowrd=$2
        .....
    }

    login $1 $2

2. **“Radiant Genesis”**
pada step ini kita pada ```register.sh``` untuk membuat suatu akun harus mematuhi, dengan format yang terlampir pada soal

#### register.sh

    .....
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    .....

    .....
    if [[ ${#password} -ge 8 && "$password" =~ [a-z] && "$password" =~ [A-Z] && "$password" =~ [0-9] ]]; then
    .....



3. **“Unceasing Spirit”**
pada step ini kita diberi tau bahwasannya email yang digunakan adalah Unique value, dan tidak bisa digunakan kembali di user lain

#### register.sh
    .....
    if grep -q "$email" $DATA_DIR/data/player.csv; then
        echo "Email sudah terdaftar"
        return 1 # Email sudah dipake
    else
        return 0 # Email belum dipake
    fi
    .....

4. **“The Eternal Realm of Light”**
pada step ini kita diminta untuk password harus di enkripsi dengan sha256sum

#### register.sh
    .....
    local encrypted_password=$(echo -n $password$salt | sha256sum | awk '{print $1}')
    .....

5. **“The Brutality of Glass”**
pada step ini kita harus membuat   ```scripts/core_monitor.sh```

#### scripts/core_monitor.sh
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}') 
    local cpu_info
    cpu_info=$(lscpu | grep "Model name" | sed "s/.*: //" | awk '{$1=$1; print}')
    local date=$(date +"%Y-%m-%d %H:%M:%S")

6. **“In Grief and Great Delight”**
pada step ini kita harus membuat ```scripts/frag_monitor.sh```\

#### scripts/frag_monitor.sh
    local ram_usage
    ram_usage=$(free -m | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}')
    local ram_count
    ram_count=$(free -m | grep Mem | awk '{print $3}')
    local total_ram
    total_ram=$(free -m | grep Mem | awk '{print $2}')
    local available_ram
    available_ram=$(free -m | grep Mem | awk '{print $7}')

7. **“On Fate's Approach”**
pada step ini kita diminta membuat ```scripts/manager.sh``` untuk mengatur jalannya secara otomatis pada script yang kita buat dengan cron

#### scripts/manager.sh
    .....
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
        .....

        while true; do
            for user in $(cut -f1 -d: /etc/passwd); do
                crontab -u $user -l 2>/dev/null > /dev/null
                if [ $? -eq 0 ]; then
                    .....
                else
                    .....
                fi
                .....
            done
            .....
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


8. **“The Disfigured Flow of Time”**
pada step ini kita harus keluarkan output dari ```scripts/core_monitor.sh``` dan ```scripts/frag_monitor``` kedalam ```$DIR/logs``` dengan output yang sesuai di soal

#### scripts/core_monitor.sh
    .....
    echo "[$date] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_info]" >> $LOG_DIR/core.log
    .....

#### scripts/frag_monitor.sh
    .....
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [${ram_usage}%] - Fragment Count [${ram_count} MB] - Details [Total: ${total_ram} MB, Available: ${available_ram} MB]" >> $LOG_DIR/fragment.log
    .....

9. “Irruption of New Color”
karena disini diminta untuk digabungkan menjadi satu maka kita harus membuat ```terminal.sh```
berikut untuk saat dijalankan saat pertama kali
    
#### terminal.sh
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

berikut saat suddah melakukan login
#### terminal.sh
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



