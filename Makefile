.DEFAULT_GOAL := help

# general
help:
	@echo "Type: make [rule]. Available options are:"
	@echo ""
	@echo "> GENERAL" 
	@echo "- help"
	@echo "- clean"
	@echo "- docker-build"
	@echo "- docker-run task=[one of make rule]"
	@echo "- docker-run-bash"
	@echo ""
	@echo "> NATIVE"
	@echo "- download-catch"
	@echo "- test"
	@echo "- clean-tests"
	@echo "- djinni-generate"
	@echo ""
	@echo "> MACOS"
	@echo "- build-zlib-macos"
	@echo "- build-openssl-macos"
	@echo "- build-curl-macos"
	@echo "- build-native-kit-macos-sdk"
	@echo ""
	@echo "> ANDROID"
	@echo "- build-zlib-android"
	@echo "- build-openssl-android"
	@echo "- build-curl-android"
	@echo "- build-swig-android"
	@echo "- build-native-kit-android"
	@echo "- build-native-kit-android-sdk"
	@echo "- android-deploy-local-debug"
	@echo "- android-deploy-local-releae"
	@echo ""
	@echo "> LINUX-64"
	@echo "- build-zlib-linux64"
	@echo "- build-openssl-linux64"
	@echo "- build-curl-linux64"
	@echo "- build-native-kit-linux64-sdk"
	@echo ""
	@echo "> iOS"
	@echo "- build-zlib-ios"
	@echo "- build-openssl-ios"
	@echo "- build-curl-ios"
	@echo "- build-native-kit-ios-sdk"
	@echo ""

clean:
	rm -rf projects/curl-android/tmp
	rm -rf projects/curl-macos/tmp
	rm -rf projects/curl-linux64/tmp
	rm -rf projects/curl-ios/tmp
	rm -rf projects/native-kit-android/build
	rm -rf projects/native-kit-android/app/build
	rm -rf projects/native-kit-macos/tmp
	rm -rf projects/native-kit-linux64/tmp
	rm -rf projects/native-kit-ios/tmp
	rm -rf projects/openssl-android/tmp
	rm -rf projects/openssl-macos/tmp
	rm -rf projects/openssl-linux64/tmp
	rm -rf projects/openssl-ios/tmp
	rm -rf projects/zlib-android/tmp
	rm -rf projects/zlib-macos/tmp
	rm -rf projects/zlib-linux64/tmp
	rm -rf projects/zlib-ios/tmp
	rm -rf tests/tmp

docker-build:
	docker build -t native-kit ./docker

docker-run:
	@echo "Task to run on docker: $(task)"
	docker run -it -v ${PWD}:/native-kit native-kit make $(task)

docker-run-bash:
	docker run -it -v ${PWD}:/native-kit native-kit bash

# native
download-catch:
	mkdir -p vendor/catch/
	curl -L https://github.com/philsquared/Catch/releases/download/v1.9.7/catch.hpp -o "vendor/catch/catch.hpp"

test:
	cd tests && ./build.sh

clean-tests:
	rm -rf tests/tmp

djinni-generate:
	rm -rf djinni/build
	cd djinni && ${DJINNI_HOME}/src/run \
	--java-out build/java-output \
	--java-package com.prsolucoes.nativekit \
	--java-cpp-exception Exception \
	--cpp-out build/cpp-output \
	--cpp-namespace NK \
	--ident-jni-class NK \
	--jni-out build/jni-output \
	--objc-out build/objc-output \
	--objc-type-prefix NK \
	--objcpp-out build/objc-output \
	--idl native-kit.djinni

	cd djinni && xcodebuild \
		-project sample/NatikeKitTest/nk.xcodeproj \
		-scheme libhelloworld_objc \
		-configuration 'Debug' \
		-sdk iphoneos

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
	cp projects/native-kit-android/app/build/outputs/apk/app-debug.apk sdk/android/native-kit-debug.apk
	cp projects/native-kit-android/app/build/outputs/apk/app-release-unsigned.apk sdk/android/native-kit-release.apk

android-deploy-local-debug:
	adb install -r sdk/android/native-kit-debug.apk
	adb shell monkey -p com.prsolucoes.nativekit -c android.intent.category.LAUNCHER 1

android-deploy-local-release:
	adb install -r sdk/android/native-kit-release.apk
	adb shell monkey -p com.prsolucoes.nativekit -c android.intent.category.LAUNCHER 1

# linux64
build-zlib-linux64:
	cd projects/zlib-linux64 && ./build.sh

build-openssl-linux64:
	cd projects/openssl-linux64 && ./build.sh

build-curl-linux64:
	cd projects/curl-linux64 && ./build.sh

build-native-kit-linux64-sdk:
	cd projects/native-kit-linux64 && ./build.sh

# ios
build-zlib-ios:
	cd projects/zlib-ios && ./build.sh

build-openssl-ios:
	cd projects/openssl-ios && ./build.sh

build-curl-ios:
	cd projects/curl-ios && ./build.sh

build-native-kit-ios-sdk:
	cd projects/native-kit-ios && ./build.sh	
