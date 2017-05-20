cmake_minimum_required(VERSION 3.0)
project(NativeKit)

include_directories(
	"../../vendor/curl-linux64/include"
	"../../source"
)

link_directories(
	"../../vendor/curl-linux64/lib"
	"../../vendor/openssl-linux64/lib"
	"../../vendor/zlib-linux64/lib"
)

add_library(
	NativeKit
	STATIC 
	../../source/http/HttpClient.cpp
)