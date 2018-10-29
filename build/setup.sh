#!/bin/bash

DOCKER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"/../docker

#if [ ! -f $DOCKER_DIR/QuartusLiteSetup-17.1.0.590-linux.run ]; then
#    wget -P $DOCKER_DIR http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/QuartusLiteSetup-17.1.0.590-linux.run
#fi
#if [ ! -f $DOCKER_DIR/ModelSimSetup-17.1.0.590-linux.run ]; then
    # wget -P $DOCKER_DIR http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/ModelSimSetup-17.1.0.590-linux.run
#fi
#if [ ! -f $DOCKER_DIR/cyclonev-17.1.0.590.qdz ]; then
#    wget -P $DOCKER_DIR http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/cyclonev-17.1.0.590.qdz a
#fi

# Integrated package with device support
#if [ ! -f $DOCKER_DIR/Quartus-lite-17.1.0.590-linux.tar ]; then
    # wget -P $DOCKER_DIR http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_tar/Quartus-lite-17.1.0.590-linux.tar
#fi

# SoC EDS, needed for software support of Cyclone V HPS
#if [ ! -f $DOCKER_DIR/SoCEDSSetup-17.1.0.590-linux.run ]; then
#    wget -P $DOCKER_DIR http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/SoCEDSSetup-17.1.0.590-linux.run
#fi


EXTERNAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"/../external
echo $EXTERNAL_DIR

if [ ! -d $EXTERNAL_DIR/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf/ ]; then
    wget -P $EXTERNAL_DIR https://releases.linaro.org/components/toolchain/binaries/7.1-2017.05/arm-linux-gnueabihf/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf.tar.xz
    tar -xf $EXTERNAL_DIR/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf.tar.xz --directory $EXTERNAL_DIR/
    rm $EXTERNAL_DIR/gcc-linaro-7.1.1-2017.05-x86_64_arm-linux-gnueabihf.tar.xz
fi
