#!/bin/bash
URL="https://ftp.gnu.org/gnu/gdb"
TARBALL="gdb-13.1.tar.xz"
DIR="gdb-13.1"
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

echo "Configure"
cd $DIR
$SUDO ./configure
echo "Make install"
$SUDO make install
echo "All done!"