@echo off
pushd %~dp0

if "%CMAKE_EXECUTABLE"=="" (
    echo "CMAKE_EXECUTABLE environment variable not set!"
    echo "Env:"
    set
    exit 2
)

echo "Getting environment from Visual Studio"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" x64

echo "Using cmake executable: %CMAKE_EXECUTABLE%"
mkdir build
pushd build
"%CMAKE_EXECUTABLE%" -G "Ninja Multi-Config" -DCMAKE_CONFIGURATION_TYPES="Debug;MinSizeRel" -DBUILD_TESTS=OFF -DBUILD_SSL=OFF -DBUILD_IPC=OFF ..
"%CMAKE_EXECUTABLE%" --build . --config Debug --parallel 4 --target clean
"%CMAKE_EXECUTABLE%" --build . --config Debug --parallel 4 --target install
"%CMAKE_EXECUTABLE%" --build . --config MinSizeRel --parallel 4 --target clean
"%CMAKE_EXECUTABLE%" --build . --config MinSizeRel --parallel 4 --target install
popd
popd
pause