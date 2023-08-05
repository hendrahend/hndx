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
# Webmin
clear
installed="${GREEN}[Installed]${NC}"
notinstalled="${RED}[Not Installed]${NC}"
cek=$(netstat -ntlp | grep 10000 | awk '{print $7}' | cut -d'/' -f2)
function install () {
    IP=$(wget -qO- ifconfig.co);
    echo " Menambahkan Repositori Webmin"
    sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
    apt install gnupg gnupg1 gnupg2 -y
    wget http://www.webmin.com/jcameron-key.asc
    apt-key add jcameron-key.asc
    echo " Mulai Install Webmin"
    clear
    sleep 0.5
    apt update > /dev/null 2>&1
    apt install webmin -y
    sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
    /etc/init.d/webmin restart
    rm -f /root/jcameron-key.asc
    clear
    echo ""
    echo " Berhasil Install Webmin"
    echo " $IP:10000"
}
function restart () {
    echo " Mulai Webmin"
    sleep 0.5
    service webmin restart > /dev/null 2>&1
    echo " Mulai Uninstall Webmin"
    clear
    echo ""
    echo " Berhasil Restart Webmin"
}
function uninstall () {
    echo " Menghapus Repositori Webmin"
    rm -f /etc/apt/sources.list.d/webmin.list
    apt update > /dev/null 2>&1
    echo " Mulai Uninstall Webmin"
    clear
    sleep 0.5
    apt autoremove --purge webmin -y > /dev/null 2>&1
    clear
    echo ""
    echo " Berhasil Uninstall Webmin"
}
if [[ "$cek" = "perl" ]]; then
    sts="${installed}"
    else
    sts="${notinstalled}"
fi
clear
echo -e " ==============================" | lolcat
echo -e "           Webmin Menu         "
echo -e " ==============================" | lolcat
echo -e " Status $sts"
echo -e "  1. Install Webmin"
echo -e "  2. Restart Webmin"
echo -e "  3. Uninstall Webmin"
echo -e " "
echo -e " Press CTRL+C to return"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
install
elif [[ "$num" = "2" ]]; then
restart
elif [[ "$num" = "3" ]]; then
uninstall
else
clear
echo "Masukkan Angka Yang Ada!"
menu
fi
