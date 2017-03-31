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
VENDOR_LIB_DIR="zlib-macos"

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

make distclean 
./configure --static
make

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