# opente
## Sources
de10-nano-hardware based on GHRD demo from terasic DE10-Nano_v.1.2.3_HWrevAB_SystemC
refer to flow described at https://bitlog.it/hardware/building-embedded-linux-for-the-terasic-de10-nano-and-other-cyclone-v-soc-fpgas/
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
## Build commands
### Hardware
1. cd bsp/de10-nano-hardware
2. make qsys_compile
3. make quartus_compile
