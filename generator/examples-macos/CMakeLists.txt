cmake_minimum_required(VERSION 3.0)
project(examples-macos)

include_directories("../../source/http")
link_directories(
	"../../build/native-kit-macos"
	"../../vendor/curl-macos"
	"../../vendor/openssl-macos"
	"../../vendor/zlib-macos"
)

add_executable(examples-macos ../../examples/desktop/main.cpp)

target_link_libraries(examples-macos ssl)
target_link_libraries(examples-macos crypto)
target_link_libraries(examples-macos curl)
target_link_libraries(examples-macos z)
target_link_libraries(examples-macos NativeKit)

# add_library(NativeKit STATIC 
# 	../../source/http/HttpClient.cpp
# )

#target_link_libraries(main ${CMAKE_SOURCE_DIR}/libbingitup.a)