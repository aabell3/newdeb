#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
curl -s -o ip.txt https://raw.githubusercontent.com/aabell3/newdeb/master/ip.txt
find=`grep $myip ip.txt`
if [ "$find" = "" ]
then
clear
echo "
      Script Auto Install By Vpsmurah.me
[ IP anda belum Memiliki Akses Untuk Menggunakan script ini ]
         Rp. 10.000 / ip untuk jasa install vps
----==== Hubungi Kontak Dibawah ====----
[ SMS/fb : 085288355698 / osip.yaroslav ]
"
rm *.txt
rm *.sh
exit
fi
if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
fi
#info
echo "=================================================="
echo "SUPPORT SERVER GOOGLE CLOUD/DIGITAL OCEAN/LINODE/etc"
echo "DEBIAN 7.X 64/32 BIT ONLY"
echo "=================================================="

clear 
#set time zone Jakarta
echo "SET TIMEZONE Jakarta GMT +7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime;
clear
echo "
CHECK AND INSTALL IT
COMPLETE 1%
"
apt-get -y install wget curl
clear
echo "
INSTALL COMMANDS
COMPLETE 15%
"

#install sudo
apt-get -y install sudo
apt-get -y wget

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

 

#ipforward
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.1.0.0/16 -o eth0 -j MASQUERADE
iptables-save

#get ip address
apt-get -y install aptitude curl

if [ "$IP" = "" ]; then
        IP=$(curl -s ifconfig.me)
fi
cd

clear
echo 
"INSTALL MENU COMMAND
39% COMPLETE "

#install menu
wget https://raw.githubusercontent.com/aabell3/newdeb/master/script/menu
wget https://raw.githubusercontent.com/aabell3/newdeb/master/script/user-list
wget https://raw.githubusercontent.com/aabell3/newdeb/master/script/monssh
wget https://raw.githubusercontent.com/aabell3/newdeb/master/script/status
wget https://raw.githubusercontent.com/aabell3/ngaco/master/null/speedtest_cli.py
wget https://raw.githubusercontent.com/aabell3/ngaco/master/freak/user-expired.sh
wget https://raw.github.com/yurisshOS/debian7os/master/autokill.sh
wget https://raw.githubusercontent.com/yurisshOS/debian7os/master/userlimit.sh
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "0 0 * * * root /root/user-expired.sh" > /etc/cron.d/user-expired.sh
echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimit
echo "@reboot root /root/autokill.sh" > /etc/cron.d/autokill
sed -i '$ i\screen -AmdS check /root/autokill.sh' /etc/rc.local
mv menu /usr/local/bin/
mv user-list /usr/local/bin/
mv monssh /usr/local/bin/
mv status /usr/local/bin/
mv speedtest_cli.py /usr/local/bin/
chmod +x user-expired.sh
chmod +x userlimit.sh
chmod +x autokill.sh
chmod +x  /usr/local/bin/menu
chmod +x  /usr/local/bin/user-list
chmod +x  /usr/local/bin/monssh
chmod +x  /usr/local/bin/status
chmod +x  /usr/local/bin/speedtest_cli.py
cd

#ssh
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
wget -O /etc/issue.net "https://raw.githubusercontent.com/aabell3/newdeb/master/script/banner"

# install screenfetch
cd
wget 'https://raw.githubusercontent.com/aabell3/ngaco/master/null/screenfetch-dev'
mv screenfetch-dev /usr/bin/screenfetch-dev
chmod +x /usr/bin/screenfetch-dev
echo "clear" >> .profile
echo "screenfetch-dev" >> .profile

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/aabell3/ngaco/master/null/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>www.vpsmurah.me</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/aabell3/ngaco/master/null/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart

clear
echo 
"65% COMPLETE"

#install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" » /etc/shells

#installing webmin
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list
apt-get update
apt-get -y install webmin
#disable webmin https
sed -i "s/ssl=1/ssl=0/g" /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
cd


clear

echo "
BLOCK TORRENT PORT INSTALL
COMPLETE 94%
"
#bonus block torrent
wget https://raw.githubusercontent.com/zero9911/script/master/script/torrent.sh
chmod +x  torrent.sh
./torrent.sh

#add user
useradd -m -g users -s /bin/bash vpsmurah
echo "vpsmurah:vpsmurah" | chpasswd

clear
echo "COMPLETE 100%"

echo "RESTART SERVICE"
service nginx start
service php-fpm start
service webmin restart
service dropbear restart
service fail2ban restart
service ssh restart
echo " DONE RESTART SERVICE"

clear

echo "===============================================--"
echo "                             "
echo "  === AUTOSCRIPT FROM VPSMURAH.ME === "
echo "WEBMIN : http://$myip:10000 "
echo "OPENVPN PORT : 59999"
echo "DROPBEAR PORT : 22,443"
echo "PROXY PORT : 7166,8080"
echo "Config OPENVPN : http://$myip/max.ovpn"
echo "SERVER TIME/LOCATION : jakarta +7"
echo "TORRENT PORT HAS BLOCK BY SCRIPT"
echo "CONTACT OWNER SCRIPT"
echo "WHATSAPP : 085288355698"
echo "fb : fb.com/osip.yaroslav"
echo "For SWAP RAM PLEASE CONTACT OWNER"
echo "  === PLEASE REBOOT TAKE EFFECT  ===  "
echo "                                  "
echo "=================================================="
rm install2.sh
