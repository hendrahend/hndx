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

# // Backup Menu
clear
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│                   BACKUP MENU                   │$NC"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo -e " ${CYAN}┌───────────────────────────────────────────────┐${NC}"
echo -e " ${CYAN}│$NC   ${CYAN}[1]${NC} • Backup"
echo -e " ${CYAN}│$NC   ${CYAN}[2]${NC} • Restore"
echo -e " ${CYAN}│$NC   ${CYAN}[0]${NC} • Back To Menu"
echo -e " ${CYAN}└───────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; backup ;;
02 | 2) clear ; restore ;;
00 | 0) clear ; menu ;;
*) clear ; menu-backup ;;
esac
