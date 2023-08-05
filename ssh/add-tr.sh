#!/bin/bash
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }


clear
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\033[0;34m┌─────────────────────────────────────────────────┐\033[0m"
echo -e "\E[0;41;36m               CREATE TROJAN ACCOUNT               \E[0m"
echo -e "\033[0;34m└─────────────────────────────────────────────────┘\033[0m"

		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
		
		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m┌─────────────────────────────────────────────────┐\033[0m"
		echo -e "\E[0;41;36m               CREATE TROJAN ACCOUNT               \E[0m"
		echo -e "\033[0;34m└─────────────────────────────────────────────────┘\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "${BIBlue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
			read -n 1 -s -r -p "Press any key to back on menu"
			trojan-menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-Success-0"`
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

systemctl restart xray
trojanlink="trojan://${uuid}@${domain}:${tr}?path=0.000000trojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
clear
echo -e "${PURPLE}════════════XRAY/TROJANWS════════════${NC}"
echo -e "Remarks     : ${user}" 
echo -e "Expired On  : $exp" 
echo -e "Host/IP     : ${domain}" 
echo -e "Port        : ${tr}" 
echo -e "Key         : ${uuid}" 
echo -e "Path        : /trojan-ws"
echo -e "Path WSS    : wss://yourbug/trojan-ws" 
echo -e "ServiceName : trojan-grpc" 
echo -e "${PURPLE}════════════════════════════════════${NC}"
echo -e "Link WS : "
echo -e "${trojanlink}" 
echo -e "${PURPLE}════════════════════════════════════${NC} "
echo -e "Link GRPC : "
echo -e "${trojanlink1}"
echo -e "${PURPLE}════════════════════════════════════${NC}" 
echo "" 
read -n 1 -s -r -p "Press any key to back on menu"

menu
