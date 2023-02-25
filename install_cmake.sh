#!/bin/bash
URL="https://github.com/Kitware/CMake/releases/download/v3.25.2"
TARBALL="cmake-3.25.2.tar.gz"
DIR="cmake-3.25.2"
SUDO="/usr/bin/sudo"

if [ $UID -eq "0" ]; then
    SUDO=""
    echo "[no sudo for root]"
fi

ldconfig -p | grep libssl
if [ $? -ne 0 ]; then
    echo "Error: libssl-dev is not installed"
    exit 1
fi

cd /tmp
rm -f $TARBALL
rm -rf $DIR

wget $URL/$TARBALL
if [ $? -ne 0 ]; then
    echo "Error: wget failed"
    exit 1
fi

echo "Extracting $TARBALL"
tar -xzf $TARBALL
if [ $? -ne 0 ]; then
    echo "Error: tar failed"
    exit 1
fi

echo "Bootstrap"
cd $DIR
$SUDO ./bootstrap
echo "Make"
$SUDO make
echo "Install"
$SUDO make install
echo "All done!"
