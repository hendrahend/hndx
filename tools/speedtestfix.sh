#!/bin/bash
clear
cd
rm -rf /usr/bin/speedtest
echo -e "\e[1;32m Start download speedtest.. \e[0m"
cd /usr/bin
wget -O speedtest "https://raw.githubusercontent.com/hendra-hendriana/tools/main/speedtest"
chmod +x speedtest
clear
echo -e "\e[1;32m Setup done Please wait.. \e[0m"
sleep 2
cd
rm -rf speedtestfix.sh
clear
echo -e "\e[1;32m auto reboot in 5s \e[0m"
sleep 5
reboot
