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
LIBRARY_VERSION="1.1.0"
LIBRARY_TARBALL="openssl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="openssl-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="openssl-ios"

# ios dev vars
DEVROOT=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
DEVELOPER=`xcode-select -print-path`
SDK_VERSION=""10.3""

# ios build function
function build_for_arch() {
	ARCH=$1
	PLATFORM=$2
	PREFIX=$3
	TARGET=$4

	export IPHONEOS_DEPLOYMENT_TARGET="8.0"	
	export CROSS_TOP="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer"
    export CROSS_SDK="${PLATFORM}${SDK_VERSION}.sdk"
    export TOOLS="${DEVELOPER}"
	export SYSROOT="${CROSS_TOP}/SDKs/${CROSS_SDK}"
	
	export PATH="${DEVROOT}/usr/bin/:${PATH}"
	export CFLAGS="-arch ${ARCH} -isysroot ${SYSROOT} -miphoneos-version-min=${IPHONEOS_DEPLOYMENT_TARGET} -fembed-bitcode"
	export LDFLAGS="-arch ${ARCH} -isysroot ${SYSROOT}"

	# for arch not: i386 and x86_64
	#sed -ie "s!static volatile sig_atomic_t intr_signal;!static volatile intr_signal;!" "crypto/ui/ui_openssl.c"

	./Configure no-async no-shared zlib --openssldir=${PREFIX} --prefix=${PREFIX} ${TARGET}
	make -j8 && make install
	make clean
}

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading ${LIBRARY_TARBALL}..."
	curl -# -o ${LIBRARY_TARBALL} -O https://www.openssl.org/source/${LIBRARY_TARBALL}
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

build_for_arch arm64 iPhoneOS ${PWD}/arm64 ios64-cross-arm64 || exit 2
build_for_arch armv7s iPhoneOS ${PWD}/armv7s ios-cross-armv7s || exit 3
build_for_arch armv7 iPhoneOS ${PWD}/armv7 ios-cross-armv7 || exit 4
build_for_arch x86_64 iPhoneSimulator ${PWD}/x86_64 ios-sim-cross-x86_64 || exit 5

${DEVROOT}/usr/bin/lipo \
	-arch x86_64 ./x86_64/lib/libcrypto.a \
	-arch armv7s ./armv7s/lib/libcrypto.a \
	-arch armv7 ./armv7/lib/libcrypto.a \
	-arch arm64 ./arm64/lib/libcrypto.a \
	-output ./libcrypto.a -create

${DEVROOT}/usr/bin/lipo \
	-arch x86_64 ./x86_64/lib/libssl.a \
	-arch armv7s ./armv7s/lib/libssl.a \
	-arch armv7 ./armv7/lib/libssl.a \
	-arch arm64 ./arm64/lib/libssl.a \
	-output ./libssl.a -create

# install process
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}

echo "Copying include files..."	

mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/
cp -R include/openssl ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/

echo "Copying files to vendor path..."

for file in libcrypto.a libssl.a; do
	file "$file"
	cp "$file" "${VENDOR_DIR}/${VENDOR_LIB_DIR}/$file"
done

echo "Finished"