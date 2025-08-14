#!/usr/bin/env node
/**
 * Fan Control for Raspberry Pi 5 - tested on Raspberry Pi 5 Model B, kernel 6.8.0
 */
import * as fs from 'fs';
import * as os from 'os';

enum FanSpeed {
  OFF = 0,
  LOW = 1,
  MEDIUM = 2,
  HIGH = 3,
  FULL = 4,
}

class Fan {
  private fanPath: string = '/sys/class/thermal/cooling_device0/cur_state';
  private tempPath: string = '/sys/devices/virtual/thermal/thermal_zone0/temp';
  private ranges: { [key: number]: FanSpeed } = {
    70: FanSpeed.FULL,
    65: FanSpeed.HIGH,
    60: FanSpeed.MEDIUM,
    55: FanSpeed.LOW,
    54: FanSpeed.OFF,
  };

  get speed(): FanSpeed {
    const speed = parseInt(fs.readFileSync(this.fanPath, 'utf-8').trim(), 10);
    return speed as FanSpeed;
  }

  setSpeed(speed: FanSpeed): void {
    fs.writeFileSync(this.fanPath, speed.toString(), 'utf-8');
  }

  getTemp(): number {
    const data = fs.readFileSync(this.tempPath, 'utf-8').trim();
    return parseFloat(data) / 1000;
  }

  adjustForTemp(): void {
    const temp = this.getTemp();
    const currentSpeed = this.speed;
    let newSpeed = currentSpeed;

    for (const [level, speed] of Object.entries(this.ranges)) {
      if (temp >= parseInt(level, 10)) {
        newSpeed = speed;
        break;
      }
    }

    this.setSpeed(newSpeed);
  }
}

function main(): void {
  const checkPaths = [
    '/sys/class/thermal/cooling_device0/cur_state',
    '/sys/devices/virtual/thermal/thermal_zone0/temp',
  ];

  let fail = false;
  for (const path of checkPaths) {
    if (!fs.existsSync(path)) {
      console.error(`Cannot find control interface at ${path}`);
      fail = true;
    }
  }

  if (fail) {
    console.error(
      'Required control interfaces are not present. Please ensure any required kernel modules are loaded.'
    );
    process.exit(-1);
  }

  const fan = new Fan();

  if (os.userInfo().uid !== 0) {
    console.error('fan control must be run as root');
    process.exit(-13);
  }

  console.log('Fan control started');
  setInterval(() => {
    try {
      fan.adjustForTemp();
    } catch (error) {
      console.error(`adjust-for-temp: ${error}`);
    }
  }, 2000);
}

if (require.main === module) {
  main();
}