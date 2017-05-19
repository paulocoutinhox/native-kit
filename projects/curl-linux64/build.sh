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
LIBRARY_VERSION="7.54.0"
LIBRARY_TARBALL="curl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="curl-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="curl-linux64"

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

export LIBS="-ldl -lpthread"

./configure \
	--prefix=${PWD}/build \
	--with-ssl=${VENDOR_DIR}/openssl-linux64 \
	--with-zlib=${VENDOR_DIR}/zlib-linux64 \
	--enable-static \
	--disable-shared \
	--disable-verbose \
	--enable-threaded-resolver \
	--enable-libgcc \
	--enable-ipv6 \
	--disable-ldaps \
	--disable-ldap \
	--disable-ftp \
	--disable-file \
	--disable-telnet \
	--disable-dict \
	--disable-tftp \
	--disable-pop3 \
	--disable-imap \
	--disable-smtp \
	--disable-rtsp \
	--disable-gopher

make
make install

# install process
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}

echo "Copying include files..."	

mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/
cp -R build/include/curl ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/

echo "Copying files to vendor path..."

for file in libcurl.a; do
	file "build/lib/$file"
	cp "build/lib/$file" "${VENDOR_DIR}/${VENDOR_LIB_DIR}/$file"
done

echo "Finished"