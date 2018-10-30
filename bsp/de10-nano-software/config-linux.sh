#!/bin/bash
cd linux-socfpga
make ARCH=arm socfpga_defconfig
make ARCH=arm menuconfig

