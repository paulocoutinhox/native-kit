git-update-submodules:
	mkdir -p vendor
	git submodule init
	git submodule update

build-curl-android:
	cd generator/curl-android && ./build.sh

build-openssl-android:
	cd generator/openssl-android && ./build.sh