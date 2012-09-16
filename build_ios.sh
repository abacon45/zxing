#!/bin/bash

set -o errexit

ROOT_DIR=`dirname $0`
cd $ROOT_DIR
ROOT_DIR=`pwd`

sim_cfg=Debug
sim_build_type=Debug
dev_cfg=Release
dev_build_type=Release
#sim_cfg=Profile
#sim_build_type=Release
#dev_cfg=Profile
#dev_build_type=Release

[ -e libzxing.a ] && rm -f libzxing.a
[ -e libzxingmm.a ] && rm -f libzxingmm.a

cd $ROOT_DIR/cpp
rm -rf build

xcodebuild -arch i386 -target zxing -configuration $sim_cfg \
   -sdk iphonesimulator5.1 -project ios.xcodeproj
xcodebuild -arch armv7 -arch armv7s -target zxing \
   -configuration $dev_cfg -project ios.xcodeproj

libtool -static -o $ROOT_DIR/libzxing.a \
   ./build/$dev_build_type-iphoneos/libzxing.a \
   ./build/$sim_build_type-iphonesimulator/libzxing.a

cd $ROOT_DIR/objc
rm -rf build

xcodebuild -arch i386 -target zxingmm -configuration $sim_cfg \
   -sdk iphonesimulator5.1 -project ios.xcodeproj
xcodebuild -arch armv7 -arch armv7s -target zxingmm \
    -configuration $dev_cfg -project ios.xcodeproj

libtool -static -o $ROOT_DIR/libzxingmm.a \
   ./build/$dev_build_type-iphoneos/libzxingmm.a \
   ./build/$sim_build_type-iphonesimulator/libzxingmm.a
