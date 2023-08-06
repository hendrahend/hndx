#!/bin/bash
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2

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

dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
dmon="$(vnstat -i eth0 -m | grep "`date +"0 '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"1001010110101100100010000010 '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"100 '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${GREEN}ON${NC}"
else
ressh="${RED}OFF${NC}"
fi
sshstunel=$(service stunnel5 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${GREEN}ON${NC}"
else
resst="${RED}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${GREEN}ON${NC}"
else
ressshws="${RED}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${GREEN}ON${NC}"
else
resngx="${RED}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${GREEN}ON${NC}"
else
resdbr="${RED}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${GREEN}ON${NC}"
else
resv2r="${RED}OFF${NC}"
fi
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
IPVPS=$(curl -s ipinfo.io/ip)
UDPX="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
clear
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${PURPLE} │  ${PURPLE}  Use Core       : ${GREEN}HNDX Tunneling ${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  OS VPS         : ${GREEN}"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` $NC
echo -e " ${PURPLE}│  ${PURPLE}  Current Domain : ${GREEN}$(cat /etc/xray/domain)${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  SlowDNS Domain : ${GREEN}$(cat /root/nsdomain)${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  IP-VPS         : ${GREEN}$IPVPS${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  ISP-Name       : ${GREEN}$ISP${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  DATE & TIME    : ${GREEN}$(date)${NC}"
echo -e " ${PURPLE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${PURPLE} │ \033[0m ${BOLD}${GREEN}        SSH             ALL-XRAY     $NC"
echo -e "${PURPLE} │ \033[0m ${Blue}         $ssh1                $vma     $NC"
echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}"
echo -e " ${PURPLE}    SSH ${NC}: $ressh"" ${PURPLE} NGINX ${NC}: $resngx"" ${PURPLE}  XRAY ${NC}: $resv2r"" ${PURPLE} TROJAN ${NC}: $resv2r"
echo -e " ${PURPLE}            DROPBEAR ${NC}: $resdbr" "${PURPLE} SSH-WS ${NC}: $ressshws"
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "  ${PURPLE}  [${GREEN}1${PURPLE}]${GREEN} SSH/UDP/SlowDNS ${NC}"
echo -e "  ${PURPLE}  [${GREEN}2${PURPLE}]${GREEN} VMESS ${NC}"
echo -e "  ${PURPLE}  [${GREEN}3${PURPLE}]${GREEN} VLESS ${NC}"
echo -e "  ${PURPLE}  [${GREEN}4${PURPLE}]${GREEN} TROJAN ${NC}"
echo -e "  ${PURPLE}  [${GREEN}5${PURPLE}]${GREEN} SHADOWSOCKS ${NC}"
echo -e "  ${PURPLE}  [${GREEN}6${PURPLE}]${GREEN} ALL USR LOGIN XRAY ${NC}"
echo -e "  ${PURPLE}  [${GREEN}7${PURPLE}]${GREEN} BACKUP/RESTORE ${NC}"
echo -e "  ${PURPLE}  [${GREEN}8${PURPLE}]${GREEN} SETTINGS ${NC}"
echo -e "  ${PURPLE}  [${GREEN}9${PURPLE}]${GREEN} INFO SCRIPT ${NC}"
echo -e "  ${PURPLE}  [${GREEN}10${PURPLE}]${GREEN} INFO SERVER ${NC}"
echo -e "  ${PURPLE}  [${GREEN}11${PURPLE}]${GREEN} INSTAL UDP ${NC}"
echo -e "  ${PURPLE}  [${GREEN}x${PURPLE}]${GREEN} EXIT ${NC}"
echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}"
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${PURPLE} │  ${GREEN}     HARI INI${NC}: ${RED}$ttoday$NC ${GREEN}KEMARIN${NC}: ${RED}$tyest$NC ${GREEN}BULAN${NC}: ${RED}$tmon$NC $NC"
echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}"
echo -e " ${PURPLE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${PURPLE}│${PURPLE}  Version  :  ${GREEN}$(cat /opt/.version)"
echo -e " ${PURPLE}└─────────────────────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; user-xray ;;
7) clear ; menu-backup ;;
8) clear ; menu-set ;;
9) clear ; info ;;
10) clear ; infoserv ;;
11) clear ; clear ; wget --load-cookies /tmp/cookies.txt ${UDPX} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
99) clear ; update ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
