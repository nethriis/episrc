#!/bin/bash
URL="https://github.com/Snaipe/Criterion/releases/download/v2.4.1"
TARBALL="criterion-2.4.1-linux-x86_64.tar.xz"
DIR="criterion-2.4.1"
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
tar -xf $TARBALL
if [ $? -ne 0 ]; then
    echo "Error: tar failed"
    exit 1
fi

echo "Create custom ld.conf"
$SUDO sh -c "echo "/usr/local/lib" > /etc/ld.so.conf.d/criterion.conf"
echo "Copy headers to $DST/include"
$SUDO cp -r $DIR/include/* $DST/include/
echo "Copy lib to $DST/lib"
$SUDO cp -r $DIR/lib/* $DST/lib/
echo "Run ldconfig"
$SUDO ldconfig
echo "All done!"
