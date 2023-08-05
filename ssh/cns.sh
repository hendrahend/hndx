#!/bin/bash
cd /usr/bin
rm -rf slowdns
wget https://raw.githubusercontent.com/Jatimpark/tunel/main/autodns/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh
echo -e "Tunggu... !!"
sleep 3
upd
sleep 2
menu
