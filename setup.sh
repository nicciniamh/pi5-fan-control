#!/bin/bash
dir="$(pwd)"
answer="none"
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
sudo cp fan-control.service /etc/systdemd/system
sudo systemctrl daemon-reload
sudo systemctrl enable fan-control.service
sudo systemctl start fan-control.service
echo "If all is well, you should see a running service in the status below"
echo ""
sudo systemctl status fan-control.service
