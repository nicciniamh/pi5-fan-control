# Fan Control for Raspberry Pi 5

## Description
With Ubuntu on Raspberry Pi 5 there is no service to monitor cpu temperature and adjust the fan accordingly. This script checks the temperature every two seconds and adjusts the fan accordingly.

This has been tested on Raspberry Pi 5 Model B, running Linux Kernel 6.8.0 and Python 3.12 under Ubuntu Linux 24.04 LTS

## Requirements
* A Raspberry Pi 5
* A suitable Linux distribution
* Python 3.4+ 

## Installation 

Clone this repository: 

```
git clone https://github.com/nicciniamh/pi5-fan-control
```

Then cd to p5i-fan-control and run ./setup.sh and follow the prompts


```
cd pi5-fan-control
./setup.sh
```

# Inspiration and Credit where Due
I wrote this inspired by [James Ashley's Pi 5 Fan Control](https://gist.github.com/James-Ansley/32f72729487c8f287a801abcc7a54f38)

# Why I wrote a new version
I wanted to integrate systemd and create a service to keep my pi cool. As I thought about it further, 
I wrote additional code based on this as part of my [SensorFS](https://github.com/nicciniamh/sensorfs)
project which also provides remote control.

The service, however, is stand-alone. No third party libraries are used.
