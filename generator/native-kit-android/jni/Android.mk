LOCAL_PATH := $(call my-dir)

# Define vars for library that will be build statically.
include $(CLEAR_VARS)
LOCAL_MODULE := libnative-kit
LOCAL_C_INCLUDES := ../../../source/http/
LOCAL_SRC_FILES := ../../../source/http/HttpClient.cpp

# Optional compiler flags.
#LOCAL_LDLIBS   = -lz -lm
#LOCAL_CFLAGS   = -Wall -pedantic -std=c99 -g

include $(BUILD_STATIC_LIBRARY)

# First lib, which will be built statically.
# include $(CLEAR_VARS)
# LOCAL_MODULE := hello-jni
# LOCAL_STATIC_LIBRARIES := <module_name>
# LOCAL_C_INCLUDES := <header_files_path>
# LOCAL_SRC_FILES := hello-jni.c

# include $(BUILD_SHARED_LIBRARY)