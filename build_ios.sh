#!/bin/bash

set -o errexit

ROOT_DIR=`dirname $0`
cd $ROOT_DIR
ROOT_DIR=`pwd`

[ -e libzxing.a ] && rm -f libzxing.a
[ -e libzxingmm.a ] && rm -f libzxingmm.a

cd $ROOT_DIR/cpp
rm -rf build

xcodebuild -arch i386 -target zxing -configuration Debug \
   -sdk iphonesimulator5.1 -project ios.xcodeproj
xcodebuild -arch armv6 -arch armv7 -target zxing \
   -sdk iphoneos5.1 -project ios.xcodeproj

libtool -static -o $ROOT_DIR/libzxing.a \
   ./build/Release-iphoneos/libzxing.a \
   ./build/Debug-iphonesimulator/libzxing.a

cd $ROOT_DIR/objc
rm -rf build

xcodebuild -arch i386 -target zxingmm -configuration Debug \
   -sdk iphonesimulator5.1 -project ios.xcodeproj
xcodebuild -arch armv6 -arch armv7 -target zxingmm \
   -sdk iphoneos5.1 -project ios.xcodeproj

libtool -static -o $ROOT_DIR/libzxingmm.a \
   ./build/Release-iphoneos/libzxingmm.a \
   ./build/Debug-iphonesimulator/libzxingmm.a
