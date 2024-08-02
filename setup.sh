#!/bin/bash
dir="$(pwd)"
answer="none"
ok="true"
if [[  $(id -u) != 0 ]] ; then
	echo "This script must be run as root" >&1
	exit 1
fi
if [[ ! -f "/sys/class/thermal/cooling_device0/cur_state" ]] ; then
	echo "Cannot find fan control interface at /sys/class/thermal/cooling_device0/cur_state" >&2
	echo "(is the pwm_fan kernel module loaded?)" >&2
	ok="false"
fi
if [[ ! -f "/sys/devices/virtual/thermal/thermal_zone0/temp" ]]; then
	echo "Cannot find CPU temperature interface at /sys/devices/virtual/thermal/thermal_zone0/temp" >&2
	ok="false"
fi
if [[ "$ok" == "false" ]] ; then
	echo "Aborting due to errors" >&2
	exit 1
fi
while [[ ${answer} != "yes" ]] ; do
	echo -n "This script will edit, install, enable, and start the service. Proceeed? [yes|no]: "
	read answer
	case $answer in
		yes ) break ;; 
		no ) exit 0 ;;
	esac
done
sed -i "s@/path/to/script@${dir}@g" fan-control.service
echo "Copying service unit. You may be asked for your password to elevate priveliges"
sudo cp fan-control.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable fan-control.service
sudo systemctl start fan-control.service
echo "If all is well, you should see a running service in the status below"
echo ""
sudo systemctl status fan-control.service
