cmake_minimum_required(VERSION 3.0)

include_directories(
	"../vendor/catch"
	"../source/http"
)

link_directories(
	"../build/native-kit-macos"
	"../vendor/curl-macos"
	"../vendor/openssl-macos"
	"../vendor/zlib-macos"
)

# HttpClient
project(HttpClientTest)

add_executable(
	HttpClientTest
	http/HttpClientTest.cpp
)

target_link_libraries(HttpClientTest ssl)
target_link_libraries(HttpClientTest crypto)
target_link_libraries(HttpClientTest curl)
target_link_libraries(HttpClientTest z)
target_link_libraries(HttpClientTest NativeKit)