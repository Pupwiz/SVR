#!/bin/bash
sudo usermod -s /bin/bash -aG sudo media
sudo usermod -s /bin/bash emby
sudo usermod -a -G media emby
sudo usermod -a -G emby media
systemctl enable emby-server
echo "Getting Things Ready Please Wait..!" | wall -n
echo "Installer adding final programs..!" | wall -n
chown media: -R /opt/mp4auto || exit 1
chown media: -R /opt/Byparr || exit 1
echo "Installing Sickbeard MP4 automation..!"  | wall -n
echo "System will reboot one last time for final updates install..!"  | wall -n
echo "Updates and software not required to make the system run will "  | wall -n
echo "now be removed please wait for the reboot. Dont force the system off..!"  | wall -n
sudo apt upgrade -qq -y
DEBIAN_FRONTEND=noninteractive apt-get -qq remove debian-faq debian-faq-de debian-faq-fr debian-faq-it debian-faq-zh-cn  doc-debian foomatic-filters hplip iamerican ibritish ispell vim-common vim-tiny reportbug laptop-detect
sudo apt autoremove -qq -y
## Remove stock bootup info and replace with custom
rm /etc/issue
cat > /etc/issue << EOF
Hostname \n
Date: \d
IP4 address: \4
Login User: \U
\t
Welcome!
EOF
##Get localhost ip and add it to organizer database
IFACE=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
NETIP=$(ip a s $IFACE | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
cat > /tmp/org.sql << ORG
 UPDATE tabs SET url = REPLACE(url,'http://127.0.0.1', 'http://$NETIP');
 UPDATE tabs SET url_local = REPLACE(url_local,'http://127.0.0.1', 'http://$NETIP');
ORG
cat /tmp/org.sql | sqlite3 /var/www/html/data/orgdb.db
rm /tmp/org.sql
#Find and update API keys for prowlarr sync 1st pass
/bin/bash /home/media/update_arr.database || exit 1
## Add cron to capture slow apps api key gen note seems to have fixed in arr updates 
#crontab -r
#(crontab -u root -l ; echo "@reboot /home/media/lateradarrkey.database ") | crontab -u root -
#(crontab -u root -l ; echo "*/2 * * * * /home/media/lateradarrkey.database ") | crontab -u root -
##Remove the root user boot override 
rm /etc/systemd/system/getty@.service.d/override.conf
## live enable tailscale to my account
#sudo tailscale up -authkey tskey-auth-ktK6yU1CNTRL-qqFSniqi2Gcu68w3z8PLDcw563WtBmYGc -ssh
rm -- "$0"
echo "Rebooting Thanks for your patience..!"  | wall -n
init 6
exit 0
