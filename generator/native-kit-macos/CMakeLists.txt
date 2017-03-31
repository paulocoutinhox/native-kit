cmake_minimum_required(VERSION 3.0)
project(NativeKit)

add_library(
	NativeKit
	STATIC 
	../../source/http/HttpClient.cpp
)