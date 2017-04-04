cmake_minimum_required(VERSION 3.0)

include_directories(
	"../../../vendor/curl-android/${ANDROID_ABI}/include"
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
	"../../../source/http/HttpClient.cpp"
	src/main/cpp/native_kit_wrap.cpp
)

target_link_libraries(
    native-kit-android
    curl
    ssl
    crypto
    z
)