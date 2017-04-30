cmake_minimum_required(VERSION 3.0)
project(NativeKit)

include_directories(
	"../../vendor/curl-linux64/include"
	"../../source"
)

link_directories(
	"../../vendor/curl-linux64"
	"../../vendor/openssl-linux64"
	"../../vendor/zlib-linux64"
)

add_library(
	NativeKit
	STATIC 
	../../source/http/HttpClient.cpp
)