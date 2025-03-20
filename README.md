
# Sisop-1-2025-IT10

# Member

    1. Muhammad Ardiansyah Tri Wibowo - 5027241091
    2. Erlinda Annisa Zahra Kusuma - 5027241108
    3. Fika Arka Nuriyah - 5027241071


# Reporting
#### SOAL 1

Soal ini meminta untuk output berupa menu dengan setiap case nya yaitu 
```

echo "pilih jawaban untuk soal ini?"
echo "1. jumlah buku yang dibaca Chris Hemsworth"
echo "2. rata-rata durasi membaca dengan tablet"
echo "3. pembaca dengan rating tertinggi"
echo "4. genre paling populer"
echo -n "jawab: "
read jawaban

```
# A. berapa banyak buku yang dibaca oleh “Chris Hemsworth”
untuk memenuhi permintaan a kita perlu membuat script mencari baris yang hanya menampilkan Chris Hemsworth dan menghitung berapa banyak baris itu muncul dengan menggunakan awk

```
    awk '/Chris Hemsworth/  { ++n }
END { print "Chris Hemsworth membaca", n, "buku." }' reading_data.csv
```
# B. menghitung rata-rata durasi membaca
kemudian untuk soal b kita perlu membuat script memfilter kata tablet dan menghitung berapa kali baris itu mmuncul dan menjumlah semua output di tabel durasi supaya bisa menghitung rata-rata. 

```
 awk -F ',' '$8 ~ /Tablet/ {total += $6; count++ }
END { rata = total/count; print "Rata-rata durasi membaca dengan Tablet adalah", rata,"menit."}' reading_data.csv
```
# C. rating tertinggi untuk buku yang dibaca
selanjutnya untuk soal c kita membuat script agar menyortir data berdasarkan kolom rating dalam urutan menurun menggunakan ```sort```, lalu menampilkan pembaca dengan rating tertinggi
```
sort -t ',' -k7 -nr reading_data.csv | awk -F ',' 'NR == 1 {max =$7} $7 == max {print "Pembaca dengan rating tertinggi : ", $2, "-" ,$3, "-", max}'
```
# D. genre yang paling sering dibaca
dan soal terkahir kita diminta untuk mencari genre paling populer, oleh karena itu kita perlu membuat script memfilter data berdasarkan wilayah ASIA dan tanggal membaca lebih dari 31 Desember 2023, lalau menghitung jumlah buku dalam setiap genre
```
awk -F',' '$9 ~ /Asia/ && $5 > "2023-12-31" {count[$4]++}
END {max=0; genre=""; for (g in count) if (count[g] > max) {max = count[g]; genre = g} print "Genre paling populer di Asia setelah 2023 adalah " genre " dengan " max " buku."}' reading_data.csv
```

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

### Soal 3
Membuat script bertemakan setidaknya ada 5 dari 10 lagu dalam album tersebut. Sebagai salah satu peserta, kamu memutuskan untuk memilih Speak to Me, On the Run, Time, Money, dan Brain Damage. Saat program ini dijalankan, terminal harus dibersihkan terlebih dahulu agar tidak mengganggu tampilan dari fungsi fungsi yang kamu buat.Program ini dijalankan dengan cara ./dsotm.sh --play=”<Track>”

    A. Speak to Me
    B. On the Run
    C. Time
    D. Money
    E. Brain Damage
## A. Speak to Me
Mengambil data https://raw.githubusercontent.com/annthurium/affirmations/refs/heads/main/affirmations.js untuk menampilkan word affirmation setiap teks.

    play_track() {
    case "$1" in
        "Speak to Me")
            title "Speak to Me"
                curl -s https://raw.githubusercontent.com/annthurium/affirmations/refs/heads/main/affirmations.js | sed '1d;$d' |  sed -E 's/^[[:space:]]*"//;s/",?$//;' | grep -v '^\];$' | while IFS= read -r line; do
		echo "$line"
                sleep 1
	done
	    ;;

# Output
![image](https://github.com/user-attachments/assets/7c8f95a0-d251-4409-820b-0b2e02f7c80c)

## B. On the Run
Membuat progress bar yang berjalan dengan interval random, tetapi setiap progress bertambah dalam interval waktu yang random dengan range 0.1 hingga 1 detik.

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

# Kendala
Outputnya progress bar tidak full hingga ke ujung kanan.
![image](https://github.com/user-attachments/assets/5d28edb3-719c-482d-9f4c-88c0953ddbe9)

# Perbaikan

     "On the Run")
            title "On the Run"
            progress=0
            bar_length=50

        while [ $progress -lt 100 ]; do
        progress=$((progress + RANDOM % 10))
        [ $progress -gt 100 ] && progress=100

        filled_length=$((progress * bar_length / 100))
        filled=$(printf '#%.0s' $(seq 1 $filled_length))

        printf "\rTunggu ya..: [%-${bar_length}s] %d%%" "$filled" "$progress" //untuk mengisi penuh tanpa ada spasi sisa yang terlihat

        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')

            done
            echo ""
            echo -e "\e[1;36m TERSELESAIKAN!^-^\e[0m"
            ;;

# Output setelah perbaikan
![image](https://github.com/user-attachments/assets/6e60aae5-5c77-4aad-b507-b315f6d5c6de)

### C. Time
Membuat Live clock yang menunjukkan hari, tanggal, jam, menit, dan detik.

 	"Time")
            title "Time"
            while true; do
            echo -ne "\r----- \e[1;33m$(date '+%A | %Y-%m-%d | %H:%M:%S') -----\e[0m"
                sleep 1
            done
            ;;

# Output
![image](https://github.com/user-attachments/assets/a8ef97ac-23af-4768-a334-cb102ac331d0)

### D. Money
Membuat program mirip dengan cmatrix tetapi isinya diganti dengan simbol  $ € £ ¥ ¢ ₹ ₩ ₿ ₣

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

# Output
![image](https://github.com/user-attachments/assets/f50d5cc7-12f3-465f-9d67-7e7dfa2e5f7a)

### E. Brain Damage
Menampilkan proses yang sedang berjalan, seperti task manager tetapi menampilkan didalam terminal dan membuat agar task managernya menampilkan data baru setiap detiknya.

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
		echo "Sayang sekali lagu anda tidak dikenali. Silakan pilih lagu yang telah disediakan: Speak to Me, On the Run, Time, Money, Brain Damage." //ketika track diluar 5 album tersebut
            	exit 1
       ;;
    esac
}

# Output
![image](https://github.com/user-attachments/assets/d285b614-e667-4d96-ab4a-610e28225262)

Lalu yang terakhir adalah play_track "$TRACK" sebagai memanggil fungsi play_track dengan argumen yang sudah diambil dari --play=<Track> di awal script.

### Soal 4

# A. Melihat Summary dari data 
untuk mencari nama pokemon dengan Usage% dan RawUsage tertinggi kita memerlukan sorting data dari terbesar ke terkecil 
```
 sort -t ',' -k2 -nr pokemon_usage.csv | awk -F ',' 'NR==1 {max=$2} $2 == max {print "Highest Adjusted Usage:",$1,"with",$2}'
            sort -t ',' -k3 -nr pokemon_usage.csv | awk -F ',' 'NR==1 {max=$3} $3 == max {print "Highest Raw Usage:",$1,"with",$3}'
```
# B. Mengurutkan Pokemon berdasarkan data kolom
untuk kolom yang berisi angka kita sort dengan numerik dan yang nama kita sort secara alfabetis
```
 "Usage")
            echo "Sorting by Usage..."
            sort -t ',' -k2 -nr pokemon_usage.csv
            ;;
        "RawUsage")
            echo "Sorting by RawUsage..."
            sort -t ',' -k3 -nr pokemon_usage.csv
            ;;
        "Nama")
            echo "Sorting by Nama..."
            sort -t ',' -f -k1 pokemon_usage.csv
            ;;
        "HP")
            echo "Sorting by HP..."
            sort -t ',' -k6 -nr pokemon_usage.csv
            ;;
        "Atk")
            echo "Sorting by Atk..."
            sort -t ',' -k7 -nr pokemon_usage.csv
            ;;
        "Def")
            echo "Sorting by Def..."
            sort -t ',' -k8 -nr pokemon_usage.csv
            ;;
        "Sp.Atk")
            echo "Sorting by Sp.Atk..."
            sort -t ',' -k9 -nr pokemon_usage.csv
            ;;
        "Sp.Def")
            echo "Sorting by Sp.Def..."
            sort -t ',' -k10 -nr pokemon_usage.csv
            ;;
        "Speed")
            echo "Sorting by Speed..."
            sort -t ',' -k11 -nr pokemon_usage.csv
            ;;
```


# C. Mencari nama pokemon tertentu

 	 case "$COMMAND" in
        --grep)
            head -n 1 "$FILE"
            grep -i "^$SEARCH_TERM" "$FILE" | sort -t ',' -k2 -r
            ;;

# Output
![image](https://github.com/user-attachments/assets/9e739819-644f-483c-9f01-8ff105c74361)





