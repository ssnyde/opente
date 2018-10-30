#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

copy_to_server() {
    echo -e "${green}Copying fpga image, device tree binary, kernel image, and rootfs into /srv/tftp and /srf/nfs${reset}"
    sudo cp de10-nano-hardware/output_files/de10_nano_hardware.rbf /srv/tftp/opente_fpga/de10_nano_hardware.rbf
    sudo cp de10-nano-hardware/soc_system.dtb /srv/tftp/opente_fpga/de10_nano_hardware.rbf
    sudo cp de10-nano-software/linux-socfpga/arch/arm/boot/zImage /srv/tftp/opente_kernel/zImage
    sudo rm -fr /srv/nfs/opente_rootfs/*
    sudo tar -xf de10-nano-software/buildroot/output/images/rootfs.tar --directory /srv/nfs/opente_rootfs/
    echo "${green}Copy complete${reset}"
}
if [ "$1" == "first" ]; then
    echo first
fi
if [ "$1" == "all" ]; then
    echo -e "${green}Building hardware${reset}"
    cd de10-nano-hardware
    make all
    cd ..
    cd de10-nano-software
    echo -e "${green}Building software${reset}"
    ./build.sh
    cd ..
    copy_to_server
fi
if [ "$1" == "copy_to_server" ]; then
    copy_to_server
fi

