build-native-kit-android-apk:
	cd build/native-kit-android && ./gradlew build

build-native-kit-android:
	cd generator/native-kit-android && ./build.sh

build-swig-android:
	cd swig && ./swig-android.sh

build-native-kit-macos:
	cd generator/native-kit-macos && ./build.sh

build-zlib-android:
	cd generator/zlib-android && ./build.sh

build-zlib-macos:
	cd generator/zlib-macos && ./build.sh

build-openssl-android:
	cd generator/openssl-android && ./build.sh

build-openssl-macos:
	cd generator/openssl-macos && ./build.sh

build-curl-android:
	cd generator/curl-android && ./build.sh

build-curl-macos:
	cd generator/curl-macos && ./build.sh

docker-build:
	docker build -t native-kit ./docker

docker-run:
	@echo "Task to run on docker: $(task)"
	docker run -it -v ${PWD}:/native-kit native-kit make $(task)

download-catch:
	mkdir -p vendor/catch/
	curl -L https://github.com/philsquared/Catch/releases/download/v1.8.2/catch.hpp -o "vendor/catch/catch.hpp"

run-tests:
	cd tests && ./build.sh