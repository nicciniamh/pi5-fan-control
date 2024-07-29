# Fan Control for Raspberry Pi 5

## Description
With Ubuntu on Raspberry Pi 5 there is no service to monitor cpu temperature and adjust the fan accordingly. This script checks the temperature every two seconds and adjusts the fan accordingly. 

## Installation 
The fan-control scipt must be on the same path referenced in fan-control.service. Please edit fan-control.service to ensure the path points to where you have installed the script. 

### Install the service file.
You must have administrative (sudo) rights on your system. Installing and enabling the service takes three easy steps: 

1. sudo cp fan-control.service /etc/systemd/system
2. sudo systemctl enable fan-control.servie
3. sudo systemctl start fan-control.servie

