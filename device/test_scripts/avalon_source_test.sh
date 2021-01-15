#!/bin/sh
# take FPGA ports of SDRAM controller out of reset
devmem2 0xffc25080 w 0x110
# clear test mode
devmem2 0xff206008 w 0
# reg_3, sdram_master address to be set (word address)
devmem2 0xff20600c w 0x0c000000
# reg_31[1] strobe to set sdram_master address to above
devmem2 0xff20607c w 0x2
devmem2 0xff20607c w 0x0
# reg_4 set number of words for avalon streaming source to stream
devmem2 0xff206010 w 16
# reg_64[2] set to strobe
devmem2 0xff206100 w 4

