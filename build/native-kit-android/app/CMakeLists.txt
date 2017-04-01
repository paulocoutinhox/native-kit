cmake_minimum_required(VERSION 3.0)

include_directories(
	"../../../source"
)

link_directories(
	"../../../vendor/curl-android/${ANDROID_ABI}"
	"../../../vendor/openssl-android/${ANDROID_ABI}"
	"../../../vendor/zlib-android/${ANDROID_ABI}"
)

add_library(
	native-kit-android
	SHARED
	src/main/cpp/HttpClient_JNI.cpp
)