#! /bin/bash

sudo apt-get install -y curl git make g++ libcurl4-openssl-dev

mkdir dlang
cd dlang

echo "Cloning dmd"
git clone https://github.com/dlang/dmd

echo "Cloning druntime"
git clone https://github.com/dlang/druntime

echo "Cloning phobos"
git clone https://github.com/dlang/phobos

echo "Building dmd"
cd dmd
make -f posix.mak -j2 AUTO_BOOTSTRAP=1

echo "Building druntime"
cd ../druntime
make -f posix.mak -j2

echo "Building phobos"
cd ../phobos
make -f posix.mak -j2

echo 'custdmd() { ~/dlang/dmd/generated/linux/release/64/dmd -I~/dlang/druntime/import/ -I~/dlang/phobos -L-L$HOME/dlang/phobos/generated/linux/release/64/ "$@" }' >> ~/.bashrc
echo 'export -f custdmd' >> ~/.bashrc
