#!/bin/bash
set -e

# use the installed cmake version not cmake from the environment
CMAKE_EXECUTABLE="/usr/local/bin/cmake" 

# switch to this script path for cmake configuration
THIS_SCRIPT_PATH="`dirname \"$0\"`"
pushd $THIS_SCRIPT_PATH

# generate the configuration and build the install targets

# this is where the environment needs to be installed...
source /opt/petalinux/2020.1/environment-setup-aarch64-xilinx-linux

mkdir -p build
pushd build

$CMAKE_EXECUTABLE -G "Ninja Multi-Config" -DCMAKE_TOOLCHAIN_FILE=../dv-aarch64-plnx64-toolchain.cmake -DCMAKE_CONFIGURATION_TYPES="Debug;MinSizeRel" -DBUILD_TESTS=OFF -DBUILD_SSL=OFF -DBUILD_IPC=OFF ..
$CMAKE_EXECUTABLE --build . --config Debug --parallel 4 --target clean
$CMAKE_EXECUTABLE --build . --config Debug --parallel 4 --target install
$CMAKE_EXECUTABLE --build . --config MinSizeRel --parallel 4 --target clean
$CMAKE_EXECUTABLE --build . --config MinSizeRel --parallel 4 --target install

popd
popd
