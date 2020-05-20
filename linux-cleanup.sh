#Clean log files
# ??

#Clean partial packages
apt-get clean && apt-get autoclean
apt-get remove --purge -y software-properties-common

#Clean packages that no longer are required
apt-get autoremove -y


#Clean orphaned packages
deborphan | xargs sudo apt-get -y remove --purge

#clean the cached packages
apt-get clean

# Clean the Trash
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

# Clean Man
rm -rf /usr/share/man/?? 
rm -rf /usr/share/man/??_*

#Remove .gz and rotated file
find /var/log -type f -regex ".*\.gz$" | xargs rm -Rf
find /var/log -type f -regex ".*\.[0-9]$" | xargs rm -Rf

#Remove old kernels
dpkg-query -l|grep linux-im*
#dpkg-query -l |grep linux-im*|awk '{print $2}'
apt-get purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | head -n -1) --assume-yes
apt-get install linux-headers-`uname -r|cut -d'-' -f3`-`uname -r|cut -d'-' -f4`
