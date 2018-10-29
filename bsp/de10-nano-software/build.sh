#!/bin/bash
cp linux.config linux-socfpga/.config
cd linux-socfpga
make ARCH=arm LOCALVERSION= zImage

