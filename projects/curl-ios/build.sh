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
LIBRARY_VERSION="7.53.1"
LIBRARY_TARBALL="curl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="curl-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="curl-ios"

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
	./configure --disable-shared --with-zlib=${VENDOR_DIR}/zlib-ios --with-ssl=${VENDOR_DIR}/openssl-ios --enable-static --enable-ipv6 ${SSL_FLAG} --host="${HOST}" --prefix=${PREFIX} && make -j8 && make install
}

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading ${LIBRARY_TARBALL}..."
	curl -# -o ${LIBRARY_TARBALL} -O https://curl.haxx.se/download/${LIBRARY_TARBALL}
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
mkdir -p ./armv7
mkdir -p ./lib

build_for_arch x86_64 x86_64-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk ${PWD}/x86_64 || exit 2
build_for_arch arm64 arm-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk ${PWD}/arm64 || exit 3
build_for_arch armv7s armv7s-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk ${PWD}/armv7s || exit 4
build_for_arch armv7 armv7-apple-darwin /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk ${PWD}/armv7 || exit 5

${DEVROOT}/usr/bin/lipo \
	-arch x86_64 ./x86_64/lib/libcurl.a \
	-arch armv7s ./armv7s/lib/libcurl.a \
	-arch armv7 ./armv7/lib/libcurl.a \
	-arch arm64 ./arm64/lib/libcurl.a \
	-output ./lib/libcurl.a -create

# patch the include file
curl -O https://raw.githubusercontent.com/sinofool/build-libcurl-ios/master/patch-include.patch
patch include/curl/curlbuild.h < patch-include.patch

# install process
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}

echo "Copying include files..."	

mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/
cp -R include/curl ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/

echo "Copying files to vendor path..."

for file in libcurl.a; do
	file "lib/$file"
	cp "lib/$file" "${VENDOR_DIR}/${VENDOR_LIB_DIR}/$file"
done

echo "Finished"