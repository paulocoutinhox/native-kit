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
VENDOR_LIB_DIR="curl-macos"

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

cmake \
	-DOPENSSL_INCLUDE_DIR=${VENDOR_DIR}/openssl-macos/include/ \
	-DOPENSSL_SSL_LIBRARY=${VENDOR_DIR}/openssl-macos/libssl.a \
	-DOPENSSL_CRYPTO_LIBRARY=${VENDOR_DIR}/openssl-macos/libcrypto.a \
	-DCURL_STATICLIB=true \
	-DCURL_ZLIB=true \
	-DCURL_DISABLE_LDAPS=true \
	-DCURL_DISABLE_LDAP=true \
	-DCURL_DISABLE_FTP=true \
	-DCURL_DISABLE_FILE=true \
	-DCURL_DISABLE_TELNET=true \
	-DCURL_DISABLE_DICT=true \
	-DCURL_DISABLE_TFTP=true \
	-DCURL_DISABLE_POP3=true \
	-DCURL_DISABLE_IMAP=true \
	-DCURL_DISABLE_SMTP=true \
	-DCURL_DISABLE_RTSP=true \
	-DCURL_DISABLE_GOPHER=true \
	-DCMAKE_USE_OPENSSL=true \
	.

make
	
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