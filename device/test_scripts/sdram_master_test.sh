#!/bin/sh
# take FPGA ports of SDRAM controller out of reset
devmem2 0xffc25080 w 0x110
# set test mode
devmem2 0xff206008 w 1
# manually strobe test start
devmem2 0xff20607c w 1
devmem2 0xff20607c w 0

