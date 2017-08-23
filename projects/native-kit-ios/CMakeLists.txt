cmake_minimum_required(VERSION 3.0)
project(NativeKit)

include_directories(
	"../../vendor/curl-ios/include"
	#"../../source"
	"../../djinni/build/cpp-output"
)

link_directories(
	"../../vendor/curl-ios"
	"../../vendor/openssl-ios"
	"../../vendor/zlib-ios"
)

set_source_files_properties(../../djinni/build/objc-output/NKHttpClient+Private.mm PROPERTIES COMPILE_FLAGS "-x objective-c++")

add_library(
	NativeKit
	STATIC 
	#../../source/http/HttpClient.cpp
	../../djinni/build/objc-output/NKHttpClient+Private.mm
)