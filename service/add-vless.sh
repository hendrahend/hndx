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
PURPLE='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

clear
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m┌─────────────────────────────────────────────────┐\033[0m"
echo -e "\E[44;1;39m              Create Xray/Vless Account            \E[0m"
echo -e "\033[0;34m└─────────────────────────────────────────────────┘\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34mт┌─────────────────────────────────────────────────┐\033[0m"
		echo -e "\E[44;1;39m              Create Xray/Vless Account             \E[0m"
		echo -e "\033[0;34mт└─────────────────────────────────────────────────┘\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			v2ray-menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-Success-0"`
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e "${PURPLE}═══════════XRAY/VLESS═══════════${NC}"
echo -e "${PURPLE}════════════════════════════════${NC}"
echo -e "Remarks       : ${user}" 
echo -e "Expired On    : $exp" 
echo -e "Domain        : ${domain}" 
echo -e "port TLS      : $tls" 
echo -e "port none TLS : $none"
echo -e "port GRPC     : $tls" 
echo -e "id            : ${uuid}"
echo -e "Encryption    : none" 
echo -e "Network       : ws" 
echo -e "Path          : /vless" 
echo -e "Path          : vless-grpc"  
echo -e "${PURPLE}════════════════════════════════${NC}"
echo -e "Link TLS :"
echo -e "${vlesslink1}" 
echo -e "${PURPLE}════════════════════════════════${NC}"   
echo -e "Link none TLS : "
echo -e "${vlesslink2}" 
echo -e "${PURPLE}════════════════════════════════${NC}"
echo -e "Link GRPC : "
echo -e "${vlesslink3}" 
echo -e "${PURPLE}════════════════════════════════${NC}" 
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
