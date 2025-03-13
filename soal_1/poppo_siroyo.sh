#!/bin/bash

echo "pilih jawaban untuk soal ini?"
echo "1. jumlah buku yang dibaca Chris Hemsworth"
echo "2. rata-rata durasi membaca dengan tablet"
echo "3. pembaca dengan rating tertinggi"
echo "4. genre paling populer"
echo -n "jawab: "
read jawaban

case "$jawaban" in
  "1")
    awk '/Chris Hemsworth/  { ++n }
END { print "Chris Hemsworth membaca", n, "buku." }' reading_data.csv
    ;;
  "2")
    awk -F ',' '$8 ~ /Tablet/ {total += $6; count++ }
END { rata = total/count; print "Rata-rata durasi membaca dengan Tablet adalah", rata,"menit."}' reading_data.csv
    ;;
  "3")
    sort -t ',' -k7 -nr reading_data.csv | awk -F ',' 'NR == 1 {max =$7} $7 == max {print "Pembaca dengan rating tertinggi : ", $2, "-" ,$3, "-", max}'
    ;;
  "4")
awk -F',' '$9 ~ /Asia/ && $5 > "2023-12-31" {count[$4]++}
END {max=0; genre=""; for (g in count) if (count[g] > max) {max = count[g]; genre = g} print "Genre paling populer di Asia setelah 2023 adalah " genre " dengan " max " buku."}' reading_data.csv
   ;;
esac
