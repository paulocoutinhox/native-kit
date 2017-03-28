#!/bin/bash -e

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# common vars
LIBRARY_VERSION="7.53.1"
LIBRARY_TARBALL="curl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="curl-${LIBRARY_VERSION}"
LIBRARY_BUILD_LOG="curl-${LIBRARY_VERSION}.log"
VENDOR_LIB_DIR="curl-android"
ARCHS=(armeabi armeabi-v7a arm64-v8a mips mips64 x86 x86_64)

# create vendor dir
VENDOR_DIR="../../../vendor"
mkdir -p ${VENDOR_DIR}
VENDOR_DIR="`cd "../../../vendor/";pwd`"

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading curl-${LIBRARY_VERSION}.tar.gz..."
	curl -# -o ${LIBRARY_TARBALL} -O https://curl.haxx.se/download/curl-${LIBRARY_VERSION}.tar.gz
fi

# untar the file
if [ ! -e ${LIBRARY_DIR} ]; then
	tar zxf ${LIBRARY_TARBALL}
fi

# create lib for each arch
for CURRENT_ARCH in ${ARCHS[@]}; do

    xLIB="/lib"
    case ${CURRENT_ARCH} in
        "armeabi")
            export _ANDROID_TARGET_SELECT=arch-arm
            export _ANDROID_ARCH=arch-arm
            export _ANDROID_EABI=arm-linux-androideabi-4.9
            configure_platform="android" ;;
        "armeabi-v7a")
            export _ANDROID_TARGET_SELECT=arch-arm
            export _ANDROID_ARCH=arch-arm
            export _ANDROID_EABI=arm-linux-androideabi-4.9
            configure_platform="android-armeabi" ;;
        "arm64-v8a")
            export _ANDROID_TARGET_SELECT=arch-arm64-v8a
            export _ANDROID_ARCH=arch-arm64
            export _ANDROID_EABI=aarch64-linux-android-4.9
            #no xLIB="/lib64"
            configure_platform="linux-generic64 -DB_ENDIAN" ;;
        "mips")
            export _ANDROID_TARGET_SELECT=arch-mips
            export _ANDROID_ARCH=arch-mips
            export _ANDROID_EABI=mipsel-linux-android-4.9
            configure_platform="android -DB_ENDIAN" ;;
        "mips64")
            export _ANDROID_TARGET_SELECT=arch-mips64
            export _ANDROID_ARCH=arch-mips64
            export _ANDROID_EABI=mips64el-linux-android-4.9
            xLIB="/lib64"
            configure_platform="linux-generic64 -DB_ENDIAN" ;;
        "x86")
            export _ANDROID_TARGET_SELECT=arch-x86
            export _ANDROID_ARCH=arch-x86
            export _ANDROID_EABI=x86-4.9
            configure_platform="android-x86" ;;
        "x86_64")
            export _ANDROID_TARGET_SELECT=arch-x86_64
            export _ANDROID_ARCH=arch-x86_64
            export _ANDROID_EABI=x86_64-4.9
            xLIB="/lib64"
            configure_platform="linux-generic64" ;;
        *)
            configure_platform="linux-elf" ;;
    esac

	# build dir
	cd ${BASE_DIR}
	LIBRARY_BUILD_DIR="${BASE_DIR}/build"
	mkdir -p ${LIBRARY_BUILD_DIR}

	# verify if the build of current arch exists
	if [ -e ${LIBRARY_BUILD_DIR}/${CURRENT_ARCH} ]; then
		echo "Build files of arch ${CURRENT_ARCH} already exists"
		continue
	fi

	# setup the environment
	chmod a+x ../setenv-android.sh
	. ../setenv-android.sh

	# build
	echo "Compiling arch: ${CURRENT_ARCH}..."
	cd ${LIBRARY_DIR}

	TARGET=android-21

	export SYSROOT="${ANDROID_NDK_ROOT}/platforms/${TARGET}/arch-arm"
	export CPPFLAGS="-I${ANDROID_NDK_ROOT}/platforms/${TARGET}/arch-arm/usr/include --sysroot=${ANDROID_SYSROOT}"
	export CC=$(${ANDROID_NDK_ROOT}/ndk-which gcc)
	export LD=$(${ANDROID_NDK_ROOT}/ndk-which ld)
	export CPP=$(${ANDROID_NDK_ROOT}/ndk-which cpp)
	export CXX=$(${ANDROID_NDK_ROOT}/ndk-which g++)
	export AS=$(${ANDROID_NDK_ROOT}/ndk-which as)
	export AR=$(${ANDROID_NDK_ROOT}/ndk-which ar)
	export RANLIB=$(${ANDROID_NDK_ROOT}/ndk-which ranlib)

	export CFLAGS="-v --sysroot=${ANDROID_SYSROOT} -mandroid -march=${ARCH} -mfloat-abi=softfp -mfpu=vfp -mthumb"
	export CPPFLAGS="${CFLAGS} -DANDROID -DCURL_STATICLIB -mthumb -mfloat-abi=softfp -mfpu=vfp -march=${ARCH} -I${VENDOR_DIR}/openssl-android/include/ -I${ANDROID_TOOLCHAIN}/include"
	export LIBS="-lssl -lcrypto"
	export LDFLAGS="-L${VENDOR_DIR}/openssl-android/${CURRENT_ARCH}"

	./buildconf

	./configure \
			--host=arm-linux-androideabi \
			--target=arm-linux-androideabi \
            --with-ssl=${VENDOR_DIR}/openssl-android \
            --enable-static \
            --disable-shared \
            --disable-verbose \
            --enable-threaded-resolver \
            --enable-libgcc \
            --enable-ipv6 \
			--with-zlib
	
	make >> ../${LIBRARY_BUILD_LOG}-${CURRENT_ARCH}
	
	# installing
	echo "Copying files..."	

	mkdir -p ${LIBRARY_BUILD_DIR}/${CURRENT_ARCH}

	for file in libcurl.a; do
        file "lib/.libs/$file"
        cp "lib/.libs/$file" "${LIBRARY_BUILD_DIR}/${CURRENT_ARCH}/$file"
    done
	
done

echo "Copying include files..."	
cd ${BASE_DIR}
cp -R ${LIBRARY_DIR}/include ${LIBRARY_BUILD_DIR}/

echo "Copying files to vendor path..."
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}
cp -R ${LIBRARY_BUILD_DIR}/* ${VENDOR_DIR}/${VENDOR_LIB_DIR}/

echo "Finished"