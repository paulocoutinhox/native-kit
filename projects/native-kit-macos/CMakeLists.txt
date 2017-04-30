cmake_minimum_required(VERSION 3.0)
project(NativeKit)

include_directories(
	"../../vendor/curl-macos/include"
	"../../source"
)

link_directories(
	"../../vendor/curl-macos"
	"../../vendor/openssl-macos"
	"../../vendor/zlib-macos"
)

add_library(
	NativeKit
	STATIC 
	../../source/http/HttpClient.cpp
)