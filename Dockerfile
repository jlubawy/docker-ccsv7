FROM ubuntu:16.04

# Update and install all packages as listed here:
# http://processors.wiki.ti.com/index.php/Linux_Host_Support_CCSv6#Ubuntu_16.04_64bit
#
# Other essential packages:
#   * at-spi2-core: for warning solved here https://github.com/NixOS/nixpkgs/issues/16327
#
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        at-spi2-core \
        gtk2-engines-murrine:i386 \
        libasound2:i386 \
        libatk1.0-0:i386 \
        libc6:i386 \
        libcairo2:i386 \
        libcanberra-gtk-module:i386 \
        libcups2:i386 \
        libdbus-glib-1-2:i386 \
        libgconf-2-4:i386 \
        libgcrypt20:i386 \
        libgdk-pixbuf2.0-0:i386 \
        libgnomeui-0:i386 \
        libgtk-3-0:i386 \
        libice6:i386 \
        libncurses5:i386 \
        liborbit2:i386 \
        libsm6:i386 \
        libstdc++6:i386 \
        libudev1:i386 \
        libusb-0.1-4:i386 \
        libusb-1.0-0-dev:i386 \
        libx11-6:i386 \
        libxt6:i386 \
        libxtst6:i386 \
        unzip

# Unattended response file generated on Windows using the following command:
# ccs_setup_7.4.0.00015.exe --save-response-file %TEMP%\ccsv7_installer_responses.txt --skip-install true
COPY ccsv7_installer_responses.txt /x/

# Download and install CCSv7
RUN apt-get install -y --no-install-recommends ca-certificates wget \
    && cd /x \
    && wget -q http://software-dl.ti.com/ccs/esd/CCSv7/CCS_7_4_0/exports/CCS7.4.0.00015_linux-x64.tar.gz \
    && tar -xvzf /x/CCS7.4.0.00015_linux-x64.tar.gz \
    && apt-get remove -y ca-certificates wget \
    && /x/CCS7.4.0.00015_linux-x64/ccs_setup_linux64_7.4.0.00015.bin \
            --mode unattended \
            --response-file /x/ccsv7_installer_responses.txt \
    && rm -rf /x/
