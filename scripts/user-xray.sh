#!/bin/bash
# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
LIGHT='\033[0;37m'
NC='\033[0m'
# Additional Configuration
export INFO="[${YELLOW} INFO ${NC}]"
export OKAY="[${GREEN} OKAY ${NC}]"
export WARNING="${RED}\e[5m"
export ERROR="[${RED} ERROR ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
export BOLD="\e[1m"
export UNDERLINE="\e[4m"
# Check ALl Users Xray
clear
echo -n >/tmp/other.txt
data=( `cat /etc/xray/config.json | grep '###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m          All Xray Login Account         \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
for akun in "${data[@]}"; do
if [[ -z "$akun" ]]; then
    akun="Tidak Ada"
fi
echo -n >/tmp/ipvmess.txt
data2=($(cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq))
for ip in "${data2[@]}"; do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
    echo "$jum" >>/tmp/ipvmess.txt
    else
        echo "$ip" >>/tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt >/dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
    echo >/dev/null
    else
        jum2=$(cat /tmp/ipvmess.txt | nl)
        echo -e "user :${GREEN} ${akun} ${NC}
        ${RED}Online Jam ${NC}: ${lastlogin} wib";
        echo "$jum2"
        echo -e "${BB}————————————————————————————————————————————————————${NC}"
fi
rm -rf /tmp/ipvmess.txt
done
rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
sleep 2
menu
