cmake_minimum_required(VERSION 3.0)

if (APPLE)
	link_directories(
		"../sdk/macos"
		"../vendor/curl-macos"
		"../vendor/openssl-macos"
		"../vendor/zlib-macos"
	)

	include_directories("../vendor/curl-macos/include")
elseif (UNIX)	
	link_directories(
		"../sdk/linux64"
		"../vendor/curl-linux64/lib"
		"../vendor/openssl-linux64/lib"
		"../vendor/zlib-linux64/lib"
	)

	include_directories("../vendor/curl-linux64/include")
else()
	message(FATAL_ERROR "System not supported to run tests")	
endif()

include_directories(
	"../vendor/catch"
	"../source/http"
)

# HttpClient
project(HttpClientTest)

add_executable(
	HttpClientTest
	http/HttpClientTest.cpp
)

target_link_libraries(HttpClientTest NativeKit)
target_link_libraries(HttpClientTest curl)
target_link_libraries(HttpClientTest ssl)
target_link_libraries(HttpClientTest crypto)
target_link_libraries(HttpClientTest z)
target_link_libraries(HttpClientTest pthread)
target_link_libraries(HttpClientTest dl)