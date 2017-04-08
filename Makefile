# general
clean:
	rm -rf projects/curl-android/tmp
	rm -rf projects/curl-macos/tmp
	rm -rf projects/curl-linux64/tmp
	rm -rf projects/native-kit-android/build
	rm -rf projects/native-kit-android/app/build
	rm -rf projects/native-kit-macos/tmp
	rm -rf projects/native-kit-linux64/tmp
	rm -rf projects/openssl-android/tmp
	rm -rf projects/openssl-macos/tmp
	rm -rf projects/openssl-linux64/tmp
	rm -rf projects/zlib-android/tmp
	rm -rf projects/zlib-macos/tmp
	rm -rf projects/zlib-linux64/tmp
	rm -rf tests/tmp

docker-build:
	docker build -t native-kit ./docker

docker-run:
	@echo "Task to run on docker: $(task)"
	docker run -it -v ${PWD}:/native-kit native-kit make $(task)

# native
download-catch:
	mkdir -p vendor/catch/
	curl -L https://github.com/philsquared/Catch/releases/download/v1.8.2/catch.hpp -o "vendor/catch/catch.hpp"

run-tests:
	cd tests && ./build.sh

clean-tests:
	rm -rf tests/tmp

# macos
build-zlib-macos:
	cd projects/zlib-macos && ./build.sh

build-openssl-macos:
	cd projects/openssl-macos && ./build.sh

build-curl-macos:
	cd projects/curl-macos && ./build.sh

build-native-kit-macos-sdk:
	cd projects/native-kit-macos && ./build.sh

# android
build-zlib-android:
	cd projects/zlib-android && ./build.sh

build-openssl-android:
	cd projects/openssl-android && ./build.sh

build-curl-android:
	cd projects/curl-android && ./build.sh

build-swig-android:
	cd swig && ./swig-android.sh

build-native-kit-android:
	cd projects/native-kit-android && ./gradlew build

build-native-kit-android-sdk:
	cd projects/native-kit-android && ./gradlew build
	mkdir -p sdk/android
	cp projects/native-kit-android/app/build/outputs/apk/app-release-unsigned.apk sdk/android/native-kit.apk

# linux64
build-zlib-linux64:
	cd projects/zlib-linux64 && ./build.sh

build-openssl-linux64:
	cd projects/openssl-linux64 && ./build.sh

build-curl-linux64:
	cd projects/curl-linux64 && ./build.sh

build-native-kit-linux64-sdk:
	cd projects/native-kit-linux64 && ./build.sh
