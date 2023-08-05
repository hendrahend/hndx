#!/bin/bash
GitUser="hendra-hendriana"
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
clear
sleep 1
echo ""
# UPDATE RUN-UPDATE
cd /usr/bin
wget -O run-upd "https://raw.githubusercontent.com/${GitUser}/hndx-autoscript/ssh/upd.sh"
chmod +x run-upd
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
clear
sleep 2
cd /usr/bin
rm -rf menu-ssh
rm -rf usernew
rm -rf add-ws
rm -rf add-tr
rm -rf restart
wget -q -O /usr/bin/usernew "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/usernew.sh"
wget -q -O /usr/bin/add-ws "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-ws.sh"
wget -q -O /usr/bin/add-ssws "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-ssws.sh"
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-vless.sh"
wget -q -O /usr/bin/add-tr "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/ssh/add-tr.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/menu/menu-ssh.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/hendra-hendriana/hndx-autoscript/main/utils/restart.sh"
chmod +x /usr/bin/usernew
chmod +x /usr/bin/add-ws
chmod +x /usr/bin/add-ssws
chmod +x /usr/bin/add-vless
chmod +x /usr/bin/add-tr
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/restart
clear
sleep 1
echo ""
cd
#echo "$ver" > /home/ver
rm -f upd.sh
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[42;1;37m    AUTOSCRIPT              \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
esac
