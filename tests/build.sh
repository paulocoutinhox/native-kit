#!/bin/bash -e

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# build process
cmake ../
make

# run tests
./HttpClientTest

echo "Finished"