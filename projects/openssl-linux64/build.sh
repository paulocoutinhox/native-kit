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
LIBRARY_VERSION="1.1.0e"
LIBRARY_TARBALL="openssl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="openssl-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="openssl-linux64"

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

./Configure no-shared zlib --with-zlib-include=${VENDOR_DIR}/zlib-linux64/include --with-zlib-lib=${VENDOR_DIR}/zlib-linux64/lib --openssldir=. linux-x86_64

make clean
make depend
make all

# install process
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}

echo "Copying include files..."	

mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}/lib/
cp -R include/openssl ${VENDOR_DIR}/${VENDOR_LIB_DIR}/include/

echo "Copying files to vendor path..."

for file in libcrypto.a libssl.a; do
	file "$file"
	cp "$file" "${VENDOR_DIR}/${VENDOR_LIB_DIR}/lib/$file"
done

echo "Finished"