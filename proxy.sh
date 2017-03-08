#!/bin/sh

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.github.com/yurisshOS/debian7os/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart
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
