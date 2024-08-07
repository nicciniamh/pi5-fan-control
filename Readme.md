# Fan Control for Raspberry Pi 5

## Description
With Ubuntu on Raspberry Pi 5 there is no service to monitor cpu temperature and adjust the fan accordingly. This script checks the temperature every two seconds and adjusts the fan accordingly.

This has been tested on Raspberry Pi 5 Model B, running Linux Kernel 6.8.0 and Python 3.12 under Ubuntu Linux 24.04 LTS

## Fan control parameters

Every two seconds the service script, fan-control, checks the cpu temperature, and compares it 
to a set of constants to determine the fan speed to set. The fan speed is represented by the FanSpeed 
enum. The values correlate to the table below. 

|Value|Fan Speed Constant | Temp |
|-----|-------------------|------|
|  4  | FanSpeed.MAX      | >70°C|
|  3  | FanSpeed.HIGH     | >65°C|
|  2  | FanSpeed.MEDIUM   | >60°C|
|  1  | FanSpeed.LOW      | >55°C|
|  0  | FanSpeed.OFF      | <55°C|

### This is a chart showing a few days of statistics on my pi5. 
![fanstats-dark.png](fanstats-dark.png#gh-dark-mode-only)
![fanstats-light.png](fanstats-light.png#gh-light-mode-only)

## Requirements
* A Raspberry Pi 5
* A suitable Linux distribution
* Python 3.4+ 

## Installation 

### Notes about the setup script.
The setup script ***must*** be run on the same path as the fan-control script and fan-control.service unit file as that is the path written to the service unit file. If you wish to move these files, simply run setup.sh agaib. 

Clone this repository: 

```
git clone https://github.com/nicciniamh/pi5-fan-control
```

Then cd to p5i-fan-control and run ./setup.sh and follow the prompts. 


```
cd pi5-fan-control
./setup.sh
```

# Inspiration and Credit where Due
I wrote this inspired by [James Ashley's Pi 5 Fan Controller](https://gist.github.com/James-Ansley/32f72729487c8f287a801abcc7a54f38)

# Why I wrote a new version
I wanted to integrate systemd and create a service to keep my pi cool. As I thought about it further, 
I wrote additional code based on this as part of my [SensorFS](https://github.com/nicciniamh/sensorfs)
project which also provides remote control.

The service, however, is stand-alone. No third party libraries are used.

# License 
This code is covered by the MIT license. Pretty basic. Please when attributing, also attribute James Ashley as the original coder. :) 
