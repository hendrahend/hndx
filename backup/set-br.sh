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
# Download & Install Rclone
clear
date
echo ""
sleep 1
echo -e "${INFO} Checking... "
sleep 2
sleep 1
echo -e "${INFO} Download & Install Rclone... "
curl -fsSL https://rclone.org/install.sh | bash > /dev/null 2>&1
printf "q\n" | rclone config > /dev/null 2>&1
sleep 1
echo -e "${INFO} Downloading rclone config ... "
wget -q -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/hendra-hendriana/hndx/main/config/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git &> /dev/null
cd wondershaper
sleep 1
echo -e "${INFO} Installing Wondershaper... "
make install > /dev/null 2>&1
cd
rm -rf wondershaper > /dev/null 2>&1
echo > /home/limit

pkgs='msmtp-mta ca-certificates bsd-mailx'
if ! dpkg -s $pkgs > /dev/null 2>&1; then
sleep 1
echo -e "${INFO} Installing CA-Certificates... "
apt install -y $pkgs > /dev/null 2>&1
else
sleep 1
echo -e "${OKAY} Already Installed... "
fi
sleep 1
echo -e "${INFO} Creating service... "
sleep 1
echo -e "${INFO} Downloading files... "
wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/hendra-hendriana/hndx/main/backup/backup.sh" && chmod +x /usr/bin/backup
wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/hendra-hendriana/hndx/main/backup/restore.sh" && chmod +x /usr/bin/restore
sleep 1
echo -e "${OKAY} Files Downloaded. "
service cron restart > /dev/null 2>&1

rm -f /root/set-br.sh
