#!/bin/bash
# Checking: run this script as root
if [ "${EUID}" -ne 0 ]; then
	echo "You need to run this script as root"
	exit 1
fi
# OpenVZ doesn't support for this script
if [ "$(systemd-detect-virt)" == "openvz" ]; then
	echo "OpenVZ is not supported"
    exit 1
fi
clear
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
# Setup Starting..
echo -e "${INFO} Welcome: Autoscript Install VPN by HNDX !"
sleep 2
# / Checking: Installed Script
if [[ -r /etc/xray/domain ]]; then
    clear
    echo -e "${INFO} Script Already Detected !"
    echo -e "${INFO} If You Replacing This Script, All Client Data Will Be Cleanup !"
    read -p "Are You Sure Replace This Script ? (Y/N) " setup
    if [[ $setup == "Y" ]]; then
        clear
        echo -e "${INFO} Replacing Script.. !"
        elif [[ $setup == "y" ]]; then
            clear
            echo -e "${INFO} Replacing Script.. !"
            rm -rf /var/lib/scrz-prem
        elif [[ $setup == "N" ]]; then
            echo -e "${INFO} Operation Canceled !"
            exit 1
        elif [[ $setup == "n" ]]; then
            echo -e "${INFO} Operation Canceled !"
            exit 1
        else
            echo -e "${ERROR} Wrong Input !"
            exit 1
    fi
    clear
fi
# / Remove Packages If Already Have
cd /root/
apt-get remove --purge apache2* -y
apt-get remove --purge dropbear* -y
apt-get remove --purge exim4* -y
apt-get remove --purge firewalld* -y
apt-get remove --purge nginx* -y
apt-get remove --purge nginx-common* -y
apt-get remove --purge nginx-full* -y
apt-get remove --purge stunnel4* -y
apt-get remove --purge ufw* -y
apt autoremove -y
# / Starting Installation
echo -e "${OKAY} Starting Installation..."
apt update -y
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc socat jq ruby wondershaper python2 tmux nmap bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget vim net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential gcc g++ automake make autoconf perl m4 dos2unix dropbear libreadline-dev zlib1g-dev libssl-dev dirmngr libxml-parser-perl neofetch git lsof iptables iptables-persistent
apt-get --reinstall --fix-missing install -y libreadline-dev zlib1g-dev libssl-dev python2 screen curl jq bzip2 gzip coreutils rsyslog iftop htop zip unzip net-tools sed gnupg gnupg1 bc sudo apt-transport-https build-essential dirmngr libxml-parser-perl neofetch screenfetch git lsof openssl easy-rsa fail2ban tmux vnstat dropbear libsqlite3-dev socat cron bash-completion ntpdate xz-utils sudo apt-transport-https gnupg2 gnupg1 dnsutils lsb-release chrony
gem install lolcat
apt update -y
apt upgrade -y
apt dist-upgrade -y
clear
clear && clear && clear
clear;clear;clear
sleep 2
echo -e "${GREEN}-----------------------------------------------------${NC}"
echo -e "Siapkan Domain Anda..."
echo -e "Kemudian Pointing Domain Ke IP VPS"
echo -e "Jika Belum Di Pointing Silahkan Lihat: https://hndx-vpn.my.id "
echo -e "${GREEN}-----------------------------------------------------${NC}"
echo ""
echo ""
read -p "Input Your Domain : " domain
read -rp "Input ur ns-domain : " -e nsdomain
echo "$nsdomain" > /etc/xray/nsdomain
echo "$nsdomain" > /root/nsdomain
if [[ $domain == "" ]]; then
    clear
    echo -e "${ERROR} No Input Detected !"
    exit 1
fi
mkdir -p /usr/bin
rm -fr /etc/nginx
rm -fr /etc/xray
rm -fr /usr/bin/xray
rm -fr /usr/local/bin/stunnel5
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/xray
rm -fr /usr/local/etc/xray
rm -fr /var/lib/scrz-prem/
mkdir -p /etc/nginx
mkdir -p /etc/xray
mkdir -p /usr/bin/xray
mkdir -p /usr/local/etc/xray
mkdir -p /var/lib/scrz-prem/
echo "$domain" > /etc/${Auther}/domain.txt
echo "IP=$domain" > /var/lib/scrz-prem/ipvps.conf
echo "$domain" > /root/domain
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain
clear
echo -e "[ ${GREEN}INFO${NC} ] Starting Renew Certificate... "
sleep 2
echo -e "${OKAY} Start Generating Certificate"
rm -fr /root/.acme.sh
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "${OKAY} Your Domain : $domain"
sleep 2
clear
clear && clear && clear
clear;clear;clear
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m          >>> Install Tools <<<          \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget -q https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/tools/vnstat.sh && chmod +x vnstat.sh && ./vnstat.sh
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m          >>> Install SSH / WS <<<        \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget -q https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/tools/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install Xray <<<         \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget -q https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/scripts/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install Backup <<<           \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget -q https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install slowdns <<<           \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget https://raw.githubusercontent.com/Andyvpn/Autoscript-by-azi/main/autoscript-ssh-slowdns-main/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh
echo -e "${GREEN}Downloading Data & Tools...${NC}"
wget -q -O /usr/bin/usernew "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/usernew.sh"
wget -q -O /usr/bin/add-ws "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-ws.sh"
wget -q -O /usr/bin/add-ssws "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-ssws.sh"
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-vless.sh"
wget -q -O /usr/bin/add-tr "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-tr.sh"
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/xp.sh"
wget -q -O /usr/bin/autoreboot "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/autoreboot.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/restart.sh"
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/tendang.sh"
wget -q -O /usr/bin/clearlog "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/clearlog.sh"
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/running.sh"
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/tools/speedtest_cli.py"
wget -q -O /usr/bin/cek-bandwidth "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/cek-bandwidth.sh"
wget -q -O /usr/bin/limitspeed "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/limitspeed.sh"
wget -q -O /usr/bin/user-xray "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/scripts/user-xray.sh"
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-vless.sh"
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-vmess.sh"
wget -q -O /usr/bin/menu-ss "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-ss.sh"
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-trojan.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-ssh.sh"
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-backup.sh"
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu.sh"
wget -q -O /usr/bin/webmin "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/webmin.sh"
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/update.sh"
wget -q -O /usr/bin/addhost "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/addhost.sh"
wget -q -O /usr/bin/certxray "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/crt.sh"
wget -q -O /usr/bin/menu-set "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-set.sh"
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/info.sh"
wget -q -O /usr/bin/infoserv "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/infoserv.sh"
wget -q -O /usr/bin/cns "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/cns.sh"
wget -q -O /usr/bin/upd "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/upd.sh"
chmod +x /usr/bin/usernew
chmod +x /usr/bin/add-ws
chmod +x /usr/bin/user-xray
chmod +x /usr/bin/add-ssws
chmod +x /usr/bin/add-vless
chmod +x /usr/bin/add-tr
chmod +x /usr/bin/autoreboot
chmod +x /usr/bin/restart
chmod +x /usr/bin/tendang
chmod +x /usr/bin/clearlog
chmod +x /usr/bin/running
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/cek-bandwidth
chmod +x /usr/bin/limitspeed
chmod +x /usr/bin/menu-vless
chmod +x /usr/bin/menu-vmess
chmod +x /usr/bin/menu-ss
chmod +x /usr/bin/menu-trojan
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/menu-backup
chmod +x /usr/bin/menu
chmod +x /usr/bin/webmin
chmod +x /usr/bin/xp
chmod +x /usr/bin/update
chmod +x /usr/bin/addhost
chmod +x /usr/bin/certxray
chmod +x /usr/bin/menu-set
chmod +x /usr/bin/info
chmod +x /usr/bin/infoserv
chmod +x /usr/bin/cns
chmod +x /usr/bin/upd
cat > /etc/cron.d/xp_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/bin/xp
END
cat > /etc/cron.d/cl_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 1 * * * root /usr/bin/clearlog
END
cat > /home/re_otm <<-END
7
END
service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1
clear
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
    rm -fr /root/log-install.txt
fi
if [ -f "/etc/afak.conf" ]; then
    rm -fr /etc/afak.conf
fi
if [ ! -f "/etc/log-create-user.log" ]; then
    echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverVersion=$( curl -sS https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/version  )
echo $serverVersion > /opt/.version
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
    then
        gg="PM"
    else
        gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps
echo  "------------------------------------------------------------"
echo  ""
echo  "   >>> Service & Port"  | tee -a log-install.txt
echo  "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo  "   - SSH Websocket           : 80" | tee -a log-install.txt
echo  "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo  "   - Stunnel5                : 447, 777" | tee -a log-install.txt
echo  "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo  "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo  "   - Nginx                   : 81" | tee -a log-install.txt
echo  "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo  "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo  "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo  "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo  "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo  "   - Trojan WS               : 443" | tee -a log-install.txt
echo  "   - Shadowsocks WS/GRPC     : 443" | tee -a log-install.txt
echo  "   - SlowDNS                 : 53,5300,443" | tee -a log-install.txt
echo  ""  | tee -a log-install.txt
echo  "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo  "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo  "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo  "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo  "   - IPtables                : [ON]"  | tee -a log-install.txt
echo  "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo  "   - Autoreboot              : 00.00 GMT +7" | tee -a log-install.txt
echo  "   - AutoKill Multi Login User" | tee -a log-install.txt
echo  "   - Auto Delete Expired Account" | tee -a log-install.txt
echo  "   - Fully automatic script" | tee -a log-install.txt
echo  "   - VPS settings" | tee -a log-install.txt
echo  "   - Restore Data" | tee -a log-install.txt
echo  "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo  "------------------------------------------------------------"
echo -e ""
echo  ""
echo  "" | tee -a log-install.txt
rm -fr /root/vnstat.sh
rm -fr /root/ssh-vpn.sh
rm -fr /root/ins-xray.sh
rm -fr /root/domain
rm -fr /root/setup.sh
history -c
echo -ne "[ ${yell}WARNING${NC} ] Apakah Anda Ingin Reboot Sekarang ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
    exit 0
    else
        reboot
fi
