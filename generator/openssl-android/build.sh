#!/bin/bash -e

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# common vars
OPENSSL_VERSION="1.1.0"
OPENSSL_TARBALL="openssl-${OPENSSL_VERSION}.tar.gz"
OPENSSL_DIR="openssl-${OPENSSL_VERSION}"
OPENSSL_BUILD_LOG="openssl-${OPENSSL_VERSION}.log"
ARCHS=(armeabi armeabi-v7a arm64-v8a mips mips64 x86 x86_64)

# create vendor dir
VENDOR_DIR="../../../vendor"
mkdir -p ${VENDOR_DIR}
VENDOR_DIR="`cd "../../../vendor/";pwd`"

# download openssl source
if [ ! -e ${OPENSSL_TARBALL} ]; then
	echo "Downloading openssl-${OPENSSL_VERSION}.tar.gz..."
	curl -# -o ${OPENSSL_TARBALL} -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
fi

# verify the source file
if [ ! -e ${OPENSSL_TARBALL}.sha1 ]; then
	echo -n "Verifying...	"
	curl -# -o ${OPENSSL_TARBALL}.sha1 -s https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz.sha1
	CHECKSUM=`cat ${OPENSSL_TARBALL}.sha1`
	ACTUAL=`shasum ${OPENSSL_TARBALL} | awk '{ print \$1 }'`
	if [ "x$ACTUAL" == "x$CHECKSUM" ]; then
		echo "OK"
	else
		echo "FAIL"
		rm -f ${OPENSSL_TARBALL}
		rm -f ${OPENSSL_TARBALL}.sha1
		false;
	fi
fi

# untar the file
if [ ! -e ${OPENSSL_DIR} ]; then
	tar zxf ${OPENSSL_TARBALL}
fi

# create lib for each arch
for CURRENT_ARCH in ${ARCHS[@]}; do

    xLIB="/lib"
    case ${CURRENT_ARCH} in
        "armeabi")
            _ANDROID_TARGET_SELECT=arch-arm
            _ANDROID_ARCH=arch-arm
            _ANDROID_EABI=arm-linux-androideabi-4.9
            configure_platform="android" ;;
        "armeabi-v7a")
            _ANDROID_TARGET_SELECT=arch-arm
            _ANDROID_ARCH=arch-arm
            _ANDROID_EABI=arm-linux-androideabi-4.9
            configure_platform="android-armeabi" ;;
        "arm64-v8a")
            _ANDROID_TARGET_SELECT=arch-arm64-v8a
            _ANDROID_ARCH=arch-arm64
            _ANDROID_EABI=aarch64-linux-android-4.9
            #no xLIB="/lib64"
            configure_platform="linux-generic64 -DB_ENDIAN" ;;
        "mips")
            _ANDROID_TARGET_SELECT=arch-mips
            _ANDROID_ARCH=arch-mips
            _ANDROID_EABI=mipsel-linux-android-4.9
            configure_platform="android -DB_ENDIAN" ;;
        "mips64")
            _ANDROID_TARGET_SELECT=arch-mips64
            _ANDROID_ARCH=arch-mips64
            _ANDROID_EABI=mips64el-linux-android-4.9
            xLIB="/lib64"
            configure_platform="linux-generic64 -DB_ENDIAN" ;;
        "x86")
            _ANDROID_TARGET_SELECT=arch-x86
            _ANDROID_ARCH=arch-x86
            _ANDROID_EABI=x86-4.9
            configure_platform="android-x86" ;;
        "x86_64")
            _ANDROID_TARGET_SELECT=arch-x86_64
            _ANDROID_ARCH=arch-x86_64
            _ANDROID_EABI=x86_64-4.9
            xLIB="/lib64"
            configure_platform="linux-generic64" ;;
        *)
            configure_platform="linux-elf" ;;
    esac

	# build dir
	cd ${BASE_DIR}
	OPENSSL_BUILD_DIR="${BASE_DIR}/build"
	mkdir -p ${OPENSSL_BUILD_DIR}

	# verify if the build of current arch exists
	if [ -e ${OPENSSL_BUILD_DIR}/${CURRENT_ARCH} ]; then
		echo "Build files of arch ${CURRENT_ARCH} already exists"
		continue
	fi

	# setup the environment
	chmod a+x ../setenv-android.sh
	. ../setenv-android.sh

	# build
	echo "Compiling arch: ${CURRENT_ARCH}..."
	cd ${OPENSSL_DIR}

	#./config shared no-asm no-zlib no-ssl3 no-comp no-hw no-engine --prefix=${OPENSSL_BUILD_DIR} --openssldir=${OPENSSL_BUILD_DIR} > ../${OPENSSL_BUILD_LOG}

	xCFLAGS="-DSHARED_EXTENSION=.so -fPIC -DOPENSSL_PIC -DDSO_DLFCN -DHAVE_DLFCN_H -mandroid -I$ANDROID_DEV/include -B$ANDROID_DEV/$xLIB -O3 -fomit-frame-pointer -Wall"

    ./Configure no-shared no-asm zlib no-ssl3 no-unit-test no-comp no-hw no-engine --openssldir=${OPENSSL_BUILD_DIR} $configure_platform $xCFLAGS > ../${OPENSSL_BUILD_LOG}-${CURRENT_ARCH}

	make clean >> ../${OPENSSL_BUILD_LOG}-${CURRENT_ARCH}
	make depend >> ../${OPENSSL_BUILD_LOG}-${CURRENT_ARCH}
	make all >> ../${OPENSSL_BUILD_LOG}-${CURRENT_ARCH}

	# installing
	echo "Copying files..."	

	mkdir -p ${OPENSSL_BUILD_DIR}/${CURRENT_ARCH}

	for file in libcrypto.a libssl.a; do
        file "$file"
        cp "$file" "${OPENSSL_BUILD_DIR}/${CURRENT_ARCH}/$file"
    done
	
done

echo "Copying include files..."	
cp -R ${OPENSSL_DIR}/include ${OPENSSL_BUILD_DIR}/

echo "Copying files to vendor path..."
rm -rf ${VENDOR_DIR}/openssl-android
mkdir -p ${VENDOR_DIR}/openssl-android
cp -R ${OPENSSL_BUILD_DIR}/* ${VENDOR_DIR}/openssl-android/

echo "Finished"