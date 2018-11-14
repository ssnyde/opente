#!/bin/bash
cd external/svunit-code/
source Setup.bsh
cd ../..
export PATH=$PATH:$HOME/intelFPGA_lite/17.1/modelsim_ase/bin
$HOME/intelFPGA_lite/17.1/embedded/embedded_command_shell.sh
