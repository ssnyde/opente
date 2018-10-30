#!/bin/bash
make -C buildroot ARCH=ARM BR2_TOOLCHAIN_EXTERNAL_PATH=$(pwd)/../../external/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf/ nconfig
make -C buildroot busybox-menuconfig
