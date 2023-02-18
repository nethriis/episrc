#!/bin/bash
URL="https://github.com/SFML/SFML/releases/download/2.5.1"
TARBALL="SFML-2.5.1-linux-gcc-64-bit.tar.gz"
DIR="SFML-2.5.1"
DST="/usr/local"
SUDO="/usr/bin/sudo"

if [ $UID -eq "0" ]; then
    SUDO=""
    echo "[no sudo for root]"
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

echo "Create custom ld.conf"
$SUDO sh -c "echo "/usr/local/lib" > /etc/ld.so.conf.d/sfml.conf"
echo "Copy headers to $DST/include"
$SUDO cp -r $DIR/include/* $DST/include
echo "Copy libs to $DST/lib"
$SUDO cp -r $DIR/lib/* $DST/lib
echo "Run ldconfig"
$SUDO ldconfig
echo "All done!"
