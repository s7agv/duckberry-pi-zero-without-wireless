#!/bin/bash
if [ $EUID -ne 0 ]; then
	echo "You must use sudo to run this script:"
	echo "sudo $0 $@"
	exit
fi
# Gets sd card root and boot path
echo Enter Raspbian root path
read rootpath
echo Enter Raspbian boot path
read bootpath
apt-get update
apt-get upgrade -y
# Install curl as first step to installing rpiupdate
apt-get install curl
# Install rpiupdate
curl -L --output /usr/bin/rpi-update https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update &&  chmod +x /usr/bin/rpi-update
# Execute general updates to raspbian
ROOT_PATH=$rootpath BOOT_PATH=$bootpath rpi-update
# Execute specific USB kernel 4.4.0+ update
ROOT_PATH=$rootpath BOOT_PATH=$bootpath BRANCH=next rpi-update c053625
echo Main setup complete. Bootpath is $bootpath , Rootpath is $rootpath
# Add dwc2 to config.txt
sed -i -e "\$adtoverlay=dwc2" "$bootpath"/config.txt
echo Appended to config.txt
# Download ossiozac's Duckberry Pi files
wget --no-check-certificate https://raw.githubusercontent.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/master/LICENSE https://raw.githubusercontent.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/master/duckpi.sh https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/g_hid.ko https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/hid-gadget-test https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/hid-gadget-test.c https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/readme.md https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/usleep https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi/raw/master/usleep.c
echo Downloaded all files.
# Move files to the pi zero sd
mv LICENSE duckpi.sh g_hid.ko hid-gadget-test hid-gadget-test.c readme.md usleep usleep.c "$rootpath"/home/pi
echo Moved files.
cd "$rootpath"/home/pi
# Make all files executeable
chmod 755 hid-gadget-test.c duckpi.sh usleep.c g_hid.ko usleep hid-gadget-test

\cp g_hid.ko "$rootpath"/lib/modules/4.4.0+/kernel/drivers/usb/gadget/legacy
echo 755 complete.
cd "$rootpath"
# Append dwc2 and hid
cat <<'EOF'>>"$rootpath"/etc/modules
dwc2
g_hid
EOF
echo Appended to modules.
cd "$rootpath"
# Edit RC local
sed -i '/exit/d' "$rootpath"/etc/rc.local
cd "$rootpath"
cat <<'EOF'>>"$rootpath"/etc/rc.local
sleep 3
cat /boot/payload.dd > /home/pi/payload.dd
sleep 1
tr -d '\r' < /home/pi/payload.dd > /home/pi/payload2.dd
sleep 1
/home/pi/duckpi.sh /home/pi/payload2.dd
exit 0
EOF
echo RCLOCAL fixed
cd "$bootpath"
# Create first payload
cat <<'EOF'>>"$bootpath"/payload.dd
DELAY 3000

GUI r

DELAY 200

STRING https://www.youtube.com/watch?v=dQw4w9WgXcQ

ENTER

DELAY 3000

STRING f
EOF
echo Default payload created.
echo Done.
