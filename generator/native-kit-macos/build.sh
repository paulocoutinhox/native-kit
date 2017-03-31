#!/bin/bash -e

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# create build dir
BUILD_DIR="../../../build"
mkdir -p ${BUILD_DIR}
BUILD_DIR="`cd "../../../build/";pwd`"

# common vars
BUILD_PROJECT_DIR="native-kit-macos"

# build process
cmake ../
make

if [ $? -ne 0 ]; then
    echo "Project build process failed"
	return 1
fi

# install process
echo "Copying files to vendor path..."
rm -rf ${BUILD_DIR}/${BUILD_PROJECT_DIR}
mkdir -p ${BUILD_DIR}/${BUILD_PROJECT_DIR}
cp libNativeKit.a ${BUILD_DIR}/${BUILD_PROJECT_DIR}/

echo "Finished"