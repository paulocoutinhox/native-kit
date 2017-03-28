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
LIBRARY_BUILD_LOG="openssl-${LIBRARY_VERSION}.log"
VENDOR_LIB_DIR="openssl-android"

# android environment vars
ANDROID_PLATFORM=android-21
ANDROID_TOOLCHAIN_VERSION="4.9"

ARCHS=(
    x86
    arm64-v8a
    armeabi
    armeabi-v7a
    mips
    mips64
    x86_64
)

TOOLS=(
    x86
    aarch64-linux-android
    arm-linux-androideabi
    arm-linux-androideabi
    mipsel-linux-android
    mips64el-linux-android
    x86_64
)

HOSTS=(
    i686-linux-android
    aarch64-linux-android
    arm-linux-androideabi
    arm-linux-androideabi
    mipsel-linux-android
    mips64el-linux-android
    x86_64-linux-android
)

SYSROOTS=(
    arch-x86
    arch-arm64
    arch-arm
    arch-arm
    arch-mips
    arch-mips64
    arch-x86_64
)

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading ${LIBRARY_TARBALL}..."
	curl -# -o ${LIBRARY_TARBALL} -O https://www.openssl.org/source/${LIBRARY_TARBALL}
fi

# untar the file
if [ ! -e ${LIBRARY_DIR} ]; then
	tar zxf ${LIBRARY_TARBALL}
fi

# create lib for each arch
for (( i=0; i<${#ARCHS[@]}; i++)); do

	# android environment vars for current arch
	tool=${TOOLS[$i]}
    arch=${ARCHS[$i]}
    host=${HOSTS[$i]}
    sysroot=${SYSROOTS[$i]}

	# build dir
	cd ${BASE_DIR}
	LIBRARY_BUILD_DIR="${BASE_DIR}/build"
	mkdir -p ${LIBRARY_BUILD_DIR}

	# build
	echo "Compiling arch: ${arch}"
	cd ${LIBRARY_DIR}

	# verify if the build of current arch exists
	if [ -e ${LIBRARY_BUILD_DIR}/${arch} ]; then
		echo "Build files of arch ${arch} already exists"
		continue
	fi

	# configure android toolchain
	export ANDROID_TOOLCHAIN=""

	for compilerHost in "linux-x86_64" "linux-x86" "darwin-x86_64" "darwin-x86"
	do
		if [ -d "${ANDROID_NDK_ROOT}/toolchains/${tool}-${ANDROID_TOOLCHAIN_VERSION}/prebuilt/${compilerHost}/bin" ]; then
			export ANDROID_TOOLCHAIN="${ANDROID_NDK_ROOT}/toolchains/${tool}-${ANDROID_TOOLCHAIN_VERSION}/prebuilt/${compilerHost}/bin"
			break
		fi
	done

	echo "Building using toolchain: ${ANDROID_TOOLCHAIN}"

	# android environment vars for build
	export ANDROID_ARCH=${sysroot}
    export ANDROID_EABI="${host}-${ANDROID_TOOLCHAIN_VERSION}"
    export ANDROID_API=${ANDROID_PLATFORM}
    export ANDROID_SYSROOT="${ANDROID_NDK_ROOT}/platforms/${ANDROID_PLATFORM}/${sysroot}"
    export ANDROID_DEV="${ANDROID_SYSROOT}/usr"

    export SYSTEM=android
    export ARCH=${arch}

	export CROSS_COMPILE_PREFIX="${host}-"

	export CC="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}gcc"
	export LD="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ld"
	export CPP="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}cpp"
	export CXX="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}g++"
	export AS="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}as"
	export AR="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ar"
	export RANLIB="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ranlib"

	# specific library build part
	OPENSSL_OS=(
		linux-generic32
		linux-generic64
		linux-generic32
		linux-generic32
		linux-generic32
		linux-generic64
		linux-generic64
	)

	ANDROID_LIB_DIR=(
		lib
		lib
		lib
		lib
		lib
		lib64
		lib64		
	)

	export SYSROOT="${ANDROID_SYSROOT}"
	export CFLAGS="--sysroot=${ANDROID_SYSROOT} -I${ANDROID_DEV}/include"	
	export CPPFLAGS="--sysroot=${ANDROID_SYSROOT} -I${ANDROID_DEV}/include"
	export CXXFLAGS="${CPPFLAGS}"
	export xCFLAGS="-B${ANDROID_DEV}/${ANDROID_LIB_DIR[$i]} -fPIC -DOPENSSL_PIC -DDSO_DLFCN -DHAVE_DLFCN_H -mandroid -O3 -fomit-frame-pointer -Wall -I${ANDROID_DEV}/include ${OPENSSL_OS[$i]}"

	./Configure ${xCFLAGS} no-shared no-asm zlib no-ssl3 no-unit-test no-comp no-hw no-engine --openssldir=${LIBRARY_BUILD_DIR} > ../${arch}-${LIBRARY_BUILD_LOG}

	make clean >> ../${arch}-${LIBRARY_BUILD_LOG}
	make depend >> ../${arch}-${LIBRARY_BUILD_LOG}
	make all >> ../${arch}-${LIBRARY_BUILD_LOG}
	
	# installing
	echo "Copying files..."	

	mkdir -p ${LIBRARY_BUILD_DIR}/${arch}

	for file in libcrypto.a libssl.a; do
        file "$file"
        cp "$file" "${LIBRARY_BUILD_DIR}/${arch}/$file"
    done
	
done

echo "Copying include files..."	
cd ${BASE_DIR}
mkdir -p ${LIBRARY_BUILD_DIR}/include/
cp -R ${LIBRARY_DIR}/include/openssl ${LIBRARY_BUILD_DIR}/include/

echo "Copying files to vendor path..."
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}
cp -R ${LIBRARY_BUILD_DIR}/* ${VENDOR_DIR}/${VENDOR_LIB_DIR}/

echo "Finished"