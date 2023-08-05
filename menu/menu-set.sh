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

# // Menu Settings
clear
echo -e "$CYAN┌─────────────────────────────────────────────────┐${NC}"
echo -e "$CYAN│                  MENU SETTINGS                  │$NC"
echo -e "$CYAN└─────────────────────────────────────────────────┘${NC}"
echo -e " $CYAN┌────────────────────────────────────────────────┐${NC}"
echo -e " $CYAN│$NC   ${CYAN}[1]${NC}  • Add Host/Domain"
echo -e " $CYAN│$NC   ${CYAN}[2]${NC}  • Renew XRAY Cert"
echo -e " $CYAN│$NC   ${CYAN}[3]${NC}  • Change NS Domain"
echo -e " $CYAN│$NC   ${CYAN}[4]${NC}  • Check Server Running"
echo -e " $CYAN│$NC   ${CYAN}[5]${NC}  • Change Server Banner"
echo -e " $CYAN│$NC   ${CYAN}[6]${NC}  • Info Bandwidth"
echo -e " $CYAN│$NC   ${CYAN}[7]${NC}  • Restart "
echo -e " $CYAN│$NC   ${CYAN}[8]${NC}  • Auto Reboot"
echo -e " $CYAN│$NC   ${CYAN}[9]${NC}  • Reboot"
echo -e " $CYAN│$NC   ${CYAN}[10]${NC} • Speedtest"
echo -e " $CYAN│$NC   ${CYAN}[11]${NC} • Limit Speed"
echo -e " $CYAN│$NC   ${CYAN}[12]${NC} • Webmin"
echo -e " $CYAN│$NC   ${CYAN}[13]${NC} • Update Script"
echo -e " $CYAN│$NC   ${CYAN}[0]${NC}  • Back To Menu"
echo -e " $CYAN└────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "  Select menu :  "  opt
echo -e   ""
case $opt in
01 | 1) clear ; addhost ;;
02 | 2) clear ; certxray ;;
03 | 3) clear ; cns ;;
04 | 4) clear ; running ;;
05 | 5) clear ; nano /etc/issue.net ;;
06 | 6) clear ; cek-bandwidth ;;
07 | 7) clear ; restart ;;
08 | 8) clear ; autoreboot ;;
09 | 9) clear ; reboot ;;
10) clear ; speedtest ;;
11) clear ; limitspeed ;;
12) clear ; webmin ;;
13) clear ; update ;;
00 | 0) clear ; menu ;;
*) clear ; menu-set ;;
esac

