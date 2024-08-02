#!/bin/bash
##
## Installation script for fan-control service
##

dir="$(pwd)"
answer="none"
ok="true"

## Check to see if we're running as root

if [[  $(id -u) != 0 ]] ; then
	echo "This script must be run as root" >&1
	exit 1
fi

##
## Check the two control interface paths we need. If one or both are not present
## set $ok = "false" so we dont continue. 
##

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

##
## Ask to proceed. Accept only yes nor no for an answer
## 

while [[ ${answer} != "yes" ]] ; do
	echo -n "This script will edit, install, enable, and start the service. Proceeed? [yes|no]: "
	read answer
	case $answer in
		yes ) break ;; 
		no ) exit 0 ;;
	esac
done
## Ediy service file to reflect script location

sed -i "s@/path/to/script@${dir}@g" fan-control.service

## Copy service file, enable and start service
echo "Copying, enabling and starting service unit."
cp fan-control.service /etc/systemd/system
systemctl daemon-reload
systemctl enable fan-control.service
systemctl start fan-control.service
echo "If all is well, you should see a running service in the status below"
echo ""
systemctl status fan-control.service
