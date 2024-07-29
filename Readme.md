# Fan Control for Raspberry Pi 5

## Description
With Ubuntu on Raspberry Pi 5 there is no service to monitor cpu temperature and adjust the fan accordingly. This script checks the temperature every two seconds and adjusts the fan accordingly.

This has been tested on Raspberry Pi 5 Model B, running Linux Kernel 6.8.0 and Python 3.12 under Ubuntu Linux 24.04 LTS

## Requirements
* A Raspberry Pi 5
* A suitable Linux distribution
* Python 3.4+ 

## Installation 
The fan-control scipt must be on the same path referenced in fan-control.service. Please edit fan-control.service to ensure the path points to where you have installed the script. 

You must change the line: 
`ExecStart=/path/to/script/fan-control` to reflect where the fan-control script is located, e.g,: `/home/joe/pi5-fan-control/fan-control`

### Install the service file.
You must have administrative (sudo) rights on your system. Installing and enabling the service takes three easy steps: 

1. sudo cp fan-control.service /etc/systemd/system
2. sudo systemctl enable fan-control.servie
3. sudo systemctl start fan-control.servie

# Inspiration and Credit where Due
I wrote this inspired by [James Ashley](https://gist.github.com/James-Ansley/32f72729487c8f287a801abcc7a54f38)
I have additional code base on this as part of my [SensorFS](https://github.com/nicciniamh/sensorfs) project, but this code 
is stand-alone meaning no exotic libraries are used. The only requirement is Python 3.4+. 

