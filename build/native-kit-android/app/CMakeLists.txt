cmake_minimum_required(VERSION 3.0)

include_directories(
	"../../../source"
	"../../../vendor/curl-android/include"
)

link_directories(
	"../../../vendor/curl-android/${ANDROID_ABI}"
	"../../../vendor/openssl-android/${ANDROID_ABI}"
	"../../../vendor/zlib-android/${ANDROID_ABI}"
	"../../../generator/native-kit-android/tmp/local/${ANDROID_ABI}"
)

add_library(
	native-kit-android
	SHARED
	src/main/cpp/HttpClient_JNI.cpp
)

target_link_libraries(
    native-kit-android
    native-kit
    curl
    ssl
    crypto
    z
)