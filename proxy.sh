#!/bin/bash

myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

#info
echo 
" INTSALL SQUID3/PROXY ONLY"
echo 
" AUTOSCRIPT START 1%"

#update
apt-get update
apt-get -y install wget
clear

echo 
" 27% COMPLETE "

#installing squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.github.com/drcyber96/autoscriptwebmin/master/conf/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart
cd

echo " 58% COMPLETE "
echo " 91% COMPLETE "
echo "100% COMPLETE"
echo " BYE-BYE"

clear

echo "================================================="
echo "                                                "
echo "  === MKSSHVPN AUTOSCRIPT ===  "
echo "PROXY PORT : 7166,8080"
echo "edit "nano /etc/squid3/squid.conf" if want to allow other IP "
echo "CONTACT OWNER SCRIPT"
echo "WHATSAPP : +60162771064"
echo "TELEGRAM : @mk_let"
echo "For SWAP RAM PLEASE CONTACT OWNER"
echo "  === PLEASE REBOOT TAKE EFFECT  ===  "
echo "                                  "
echo "=================================================="
rm proxy.sh
