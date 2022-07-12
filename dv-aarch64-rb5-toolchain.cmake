cmake_minimum_required(VERSION 3.18)
if (DEFINED ENV{RB5_GCC} AND DEFINED ENV{RB5_SYSROOT}) 

    cmake_path(CONVERT $ENV{RB5_GCC} TO_CMAKE_PATH_LIST RB5_GCC_PATH)
    cmake_path(CONVERT $ENV{RB5_SYSROOT} TO_CMAKE_PATH_LIST RB5_SYSROOT_PATH)

    set(RB5_COMPILER_EXT "")
    if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
        set(RB5_COMPILER_EXT ".exe")
    endif()

    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_SYSTEM_PROCESSOR arm)
    set(CMAKE_SYSROOT "${RB5_SYSROOT_PATH}")
    set(CMAKE_C_COMPILER "${RB5_GCC_PATH}/bin/aarch64-linux-gnu-gcc${RB5_COMPILER_EXT}")
    set(CMAKE_CXX_COMPILER "${RB5_GCC_PATH}/bin/aarch64-linux-gnu-g++${RB5_COMPILER_EXT}")
    set(CMAKE_STRIP "${RB5_GCC_PATH}/bin/aarch64-linux-gnu-strip${RB5_COMPILER_EXT}")
    
else()
    message(FATAL_ERROR "RB5_GCC and RB5_SYSROOT environment variable not defined...")
endif() 

