#!/bin/bash -e

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# create vendor dir
VENDOR_DIR="../../../vendor"
mkdir -p ${VENDOR_DIR}
VENDOR_DIR="`cd "../../../vendor/";pwd`"

# common vars
LIBRARY_VERSION="1.2.11"
LIBRARY_TARBALL="zlib-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="zlib-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="zlib-ios"

# ios dev vars
DEVROOT=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain

# ios build function
function build_for_arch() {
	ARCH=$1
	HOST=$2
	SYSROOT=$3
	PREFIX=$4
	IPHONEOS_DEPLOYMENT_TARGET="6.0"
	export PATH="${DEVROOT}/usr/bin/:${PATH}"
	export CFLAGS="-DCURL_BUILD_IOS -arch ${ARCH} -pipe -Os -gdwarf-2 -isysroot ${SYSROOT} -miphoneos-version-min=${IPHONEOS_DEPLOYMENT_TARGET} -fembed-bitcode"
	export LDFLAGS="-arch ${ARCH} -isysroot ${SYSROOT}"
	make distclean 
	./configure --static --prefix=${PREFIX} && make -j8 && make install
	make
}

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading ${LIBRARY_TARBALL}..."
	curl -# -o ${LIBRARY_TARBALL} -O http://zlib.net/${LIBRARY_TARBALL}
fi

# untar the file
if [ ! -e ${LIBRARY_DIR} ]; then
	tar zxf ${LIBRARY_TARBALL}
fi

# build process
cd ${LIBRARY_DIR}

mkdir -p ./x86_64
mkdir -p ./arm64
mkdir -p ./armv7s

build_for_arch x86_64 x86_64-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk ${PWD}/x86_64 || exit 2
build_for_arch arm64 arm-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk ${PWD}/arm64 || exit 3
build_for_arch armv7s armv7s-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk ${PWD}/armv7s || exit 4

${DEVROOT}/usr/bin/lipo \
	-arch x86_64 ./x86_64/lib/libz.a \
	-arch armv7s ./armv7s/lib/libz.a \
	-arch arm64 ./arm64/lib/libz.a \
	-output ./libz.a -create

# install process
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}

echo "Copying include files..."	

mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/
cp -R z*.h ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/

echo "Copying files to vendor path..."

for file in libz.a; do
	file "$file"
	cp "$file" "${VENDOR_DIR}/${VENDOR_LIB_DIR}/$file"
done

echo "Finished"