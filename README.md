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
### Setup, download binary toolchain
1. ./build/setup.sh
### Hardware, netboot
1. cd bsp/de10-nano-hardware
2. make all
3. make sd-create-image-netboot
4. cd bsp/de10-nano-software
### Software
1. cd host/vxi11-cmd
2. make
3. cd host/vxi11-device-logic-analyzer
4. make
### Output files
Bootloader image: bsp/de10-nano-hardware/sd-card-netboot.img
Host vxi11 command tool: out/host/vxi11-cmd/bin/vxi11-cmd
Device vxi11 logic analyzer service: out/device/vxi11-device-logic-analyzer/bin/vxi11_svc

