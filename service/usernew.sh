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
NC='\e[0m'
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

clear
sldomain=$(cat /root/nsdomain)
# cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear
cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
domen=`cat /etc/xray/domain`
else
domen=`cat /etc/v2ray/domain`
fi
portsshws=`cat /root/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

echo -e "$PURPLE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[0;41;36m        Create SSH Account            \E[0m"
echo -e "$PURPLE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat /root/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat /root/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`

sleep 1
clear
useradd -e `date -d "$masaaktif days" +"%Y-No such file or directory-0"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
    echo -e "${PURPLE}════════════SSH ACCOUNTS══════════${NC}"
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "Username   : $Login" 
    echo -e "Password   : $Pass"
    echo -e "Expired On : $exp" 
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "IP         : $IP" 
    echo -e "Host       : $domen" 
    echo -e "Nameserver : $sldomain" | tee -a /etc/log-create-user.log
    echo -e "PubKey     : $slkey" | tee -a /etc/log-create-user.log
    echo -e "OpenSSH    : $opensh"
    echo -e "Dropbear   : $db" 
    echo -e "SSH-WS     : $portsshws" 
    echo -e "SSH WS SSL : $wsssl" 
    echo -e "SSL/TLS    : $ssl" 
    echo -e "SlowDNS    : 53,5300,443" 
    echo -e "SSH UDP    : $domen:1-65535@$Login:$Pass" 
    echo -e "UDPGW      : 7100-7300" 
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "GET / HTTP/1.1[crlf]Host: $domen[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    else
    echo -e "${PURPLE}════════════SSH ACCOUNTS══════════${NC}"
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "Username   : $Login" 
    echo -e "Password   : $Pass"
    echo -e "Expired On : $exp" 
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "IP         : $IP" 
    echo -e "Host       : $domen" 
    echo -e "Nameserver : $sldomain" | tee -a /etc/log-create-user.log
    echo -e "PubKey     : $slkey" | tee -a /etc/log-create-user.log
    echo -e "OpenSSH    : $opensh"
    echo -e "Dropbear   : $db" 
    echo -e "SSH-WS     : $portsshws" 
    echo -e "SSH-SSL-WS : $wsssl" 
    echo -e "SSL/TLS    : $ssl" 
    echo -e "SlowDNS    : 53,5300,443" 
    echo -e "SSH UDP    : $domen:1-65535@$Login:$Pass" 
    echo -e "UDPGW      : 7100-7300" 
    echo -e "${PURPLE}══════════════════════════════════${NC}"
    echo -e "GET / HTTP/1.1[crlf]Host: $domen[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]"
    echo -e "${PURPLE}══════════════════════════════════${NC}"
fi
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu