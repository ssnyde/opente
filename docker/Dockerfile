FROM debian:stretch

ENV TERM dumb

# apt config:  silence warnings and set defaults
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

USER root

# Individual downloads Quartus, ModelSim and Device Support
# ADD http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/QuartusLiteSetup-17.1.0.590-linux.run /tmp/
# ADD http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/ModelSimSetup-17.1.0.590-linux.run /tmp/ 
# ADD http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/cyclonev-17.1.0.590.qdz /tmp/
# Integrated package with device support
# ADD http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_tar/Quartus-lite-17.1.0.590-linux.tar /tmp/
# SoC EDS, needed for software support of Cyclone V HPS
# ADD http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_installers/SoCEDSSetup-17.1.0.590-linux.run /tmp/

# If downloaded ahead of time, speeds things up when updating dockerfile, just remember to delete to save space
ADD QuartusLiteSetup-17.1.0.590-linux.run /tmp/
ADD cyclonev-17.1.0.590.qdz /tmp/
ADD SoCEDSSetup-17.1.0.590-linux.run /tmp/

# Fix file permissions
RUN cd /tmp/ && \
    chmod +wx *.run && \
    chmod +r *

# Create a non-root user for builds
RUN adduser --disabled-password --gecos '' builder && \
    usermod builder -aG staff

# turn off recommends on container OS
# install required dependencies
RUN echo 'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";' > \
    /etc/apt/apt.conf.d/01norecommend && \
    apt-get update && \
    apt-get -y install \
        ca-certificates \
        git \
        libfontconfig1 \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        locales \
        make \
        xauth \
        xvfb \
	pkg-config \
	libprotobuf-dev \
	protobuf-compiler \
	python-protobuf \
	python-pip \
	libpng16-16 \
	udisks2 \
	sudo && \
    pip install intelhex

# Set the locale, Quartus expects en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Quartus
USER builder
RUN cd /tmp/ && \
    ./QuartusLiteSetup-17.1.0.590-linux.run --mode unattended --accept_eula 1

RUN cd /tmp/ && \
    ./SoCEDSSetup-17.1.0.590-linux.run --mode unattended --accept_eula 1 \
    --installdir /home/builder/intelFPGA_lite/17.1/

ENV PATH $PATH:/home/builder/intelFPGA_lite/17.1/quartus/bin

# Cleanup to save space
#USER root
#RUN rm -rf /tmp/* && \
#    apt-get clean
#USER builder

RUN /home/builder/intelFPGA_lite/17.1/embedded/embedded_command_shell.sh

# Allow builder to sudo without password
USER root
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder
