#!/bin/bash -e

# validate
if [ -z ${ANDROID_NDK_ROOT+x} ]; then
	echo "Error: You need set ANDROID_NDK_ROOT environment variable"
	exit 1
fi

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"

# create vendor dir
VENDOR_DIR="../../../vendor"
mkdir -p ${VENDOR_DIR}
VENDOR_DIR="`cd "../../../vendor/";pwd`"

# build process
ndk-build \
	NDK_OUT=${BASE_DIR}/

echo "Finished"