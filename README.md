# opente
## Directory Structure
```
common\
host\
  vxi11-cmd\
bsp\
  de10-nano-hardware\
    Hardware specific to the de10-nano platform
  de10-nano-software\
    Software specific to the de10-nano, including bootloader, kernel, and rootfs configs.
device\
  hardware-logic-analyzer
    Hardware for implementing a logic analyzer
  vxi11-device-logic-analyzer\
    Software for implmenting a vxi11 device interface to the logic analyzer hardware
external\
  Submodules for external source code
```
