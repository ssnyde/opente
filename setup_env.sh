#!/bin/bash
cd external/svunit-code/
source Setup.bsh
cd ../..
export PATH=$PATH:$HOME/intelFPGA_lite/17.1/modelsim_ase/bin
export CROSS_COMPILE=$PWD/external/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

#line below must be last to inherit the previous exports
$HOME/intelFPGA_lite/17.1/embedded/embedded_command_shell.sh

