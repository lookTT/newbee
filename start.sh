#!/bin/sh

echo "making the project"
cd build
make
./newbee config.lua
