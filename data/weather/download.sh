#!/usr/bin/env bash
set -euo pipefail
for year in 2018 2019 2020
do
    for month in '01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12'
    do
        wget "https://danepubliczne.imgw.pl/data/dane_pomiarowo_obserwacyjne/dane_meteorologiczne/dobowe/klimat/${year}/${year}_${month}_k.zip"
        unzip "${year}_${month}_k.zip"
    done
done
wget "https://danepubliczne.imgw.pl/data/dane_pomiarowo_obserwacyjne/dane_meteorologiczne/dobowe/klimat/2021/2021_01_k.zip"
unzip "2021_01_k.zip"
#not included month yet
#wget "https://danepubliczne.imgw.pl/data/dane_pomiarowo_obserwacyjne/dane_meteorologiczne/dobowe/klimat/2021/2021_02_k.zip"
#unzip "2021_02_k.zip"

echo '"Kod stacji","Nazwa stacji","Rok","Miesi�c","Dzie�","Maksymalna temperatura dobowa [�C]","Status pomiaru TMAX","Minimalna temperatura dobowa [�C]","Status pomiaru TMIN","�rednia temperatura dobowa [�C]","Status pomiaru STD","Temperatura minimalna przy gruncie [�C]","Status pomiaru TMNG","Suma dobowa opad�w [mm]","Status pomiaru SMDB","Rodzaj opadu  [S/W/ ]","Wysoko�� pokrywy �nie�nej [cm]","Status pomiaru PKSN"' > k_d_header
echo '"Kod stacji","Nazwa stacji","Rok","Miesi�c","Dzie�","�rednia dobowa temperatura  [�C]","Status pomiaru TEMP","�rednia dobowa wilgotno�� wzgl�dna [%]","Status pomiaru WLGS","�rednia dobowa pr�dko�� wiatru [m/s]","Status pomiaru FWS","�rednie dobowe zachmurzenie og�lne [oktanty]","Status pomiaru NOS"' > k_d_t_header
rm *.zip
cat k_d_t_header k_d_t_*.csv >> kdt.csv
rm k_d_t_*.csv
rm k_d_t_header
cat k_d_header k_d_*.csv >> kd.csv
rm k_d_*.csv
rm k_d_header

iconv -f CP1250 -t UTF-8//TRANSLIT kdt.csv -o k_d_t.csv
iconv -f CP1250 -t UTF-8//TRANSLIT kd.csv -o k_d.csv
rm kd.csv
rm kdt.csv
