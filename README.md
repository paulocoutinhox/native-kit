# ERROR

```
$ ./gradlew build
Incremental java compilation is an incubating feature.
:app:preBuild UP-TO-DATE
:app:preDebugBuild UP-TO-DATE
:app:checkDebugManifest
:app:preReleaseBuild UP-TO-DATE
:app:prepareComAndroidSupportAnimatedVectorDrawable2530Library
:app:prepareComAndroidSupportAppcompatV72530Library
:app:prepareComAndroidSupportConstraintConstraintLayout100Alpha9Library
:app:prepareComAndroidSupportSupportCompat2530Library
:app:prepareComAndroidSupportSupportCoreUi2530Library
:app:prepareComAndroidSupportSupportCoreUtils2530Library
:app:prepareComAndroidSupportSupportFragment2530Library
:app:prepareComAndroidSupportSupportMediaCompat2530Library
:app:prepareComAndroidSupportSupportV42530Library
:app:prepareComAndroidSupportSupportVectorDrawable2530Library
:app:prepareDebugDependencies
:app:compileDebugAidl UP-TO-DATE
:app:compileDebugRenderscript UP-TO-DATE
:app:generateDebugBuildConfig UP-TO-DATE
:app:generateDebugResValues UP-TO-DATE
:app:generateDebugResources UP-TO-DATE
:app:mergeDebugResources UP-TO-DATE
:app:processDebugManifest UP-TO-DATE
:app:processDebugResources UP-TO-DATE
:app:generateDebugSources UP-TO-DATE
:app:incrementalDebugJavaCompilationSafeguard UP-TO-DATE
:app:javaPreCompileDebug
:app:compileDebugJavaWithJavac UP-TO-DATE
:app:generateJsonModelDebug UP-TO-DATE
:app:externalNativeBuildDebug
Build native-kit-android mips64
[1/1] Re-running CMake...
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/.externalNativeBuild/cmake/debug/mips64
[1/1] Linking CXX shared library ../../../../build/intermediates/cmake/debug/obj/mips64/libnative-kit-android.so
FAILED: : && /Users/paulo/Developer/android-ndk-r13b/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang++  -target mips64el-none-linux-android -gcc-toolchain /Users/paulo/Developer/android-ndk-r13b/toolchains/mips64el-linux-android-4.9/prebuilt/darwin-x86_64 --sysroot=/Users/paulo/Developer/android-ndk-r13b/platforms/android-21/arch-mips64 -fPIC -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -Wa,--noexecstack -Wformat -Werror=format-security -fno-exceptions -fno-rtti  -O0 -fno-limit-debug-info  -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--no-undefined -Wl,-z,noexecstack -Qunused-arguments -Wl,-z,relro -Wl,-z,now -shared -Wl,-soname,libnative-kit-android.so -o ../../../../build/intermediates/cmake/debug/obj/mips64/libnative-kit-android.so CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/curl-android/mips64  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips64  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/zlib-android/mips64 -lm "/Users/paulo/Developer/android-ndk-r13b/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips64/libgnustl_static.a" && :
CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o: In function `Java_com_prsolucoes_nativekit_HttpClient_get':
/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/src/main/cpp/HttpClient_JNI.cpp:32: undefined reference to `NK::HttpClient::get(std::string)'
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.
:app:externalNativeBuildDebug FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:externalNativeBuildDebug'.
> Build command failed.
  Error while executing process /Users/paulo/Library/Android/sdk/cmake/3.6.3155560/bin/cmake with arguments {--build /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/.externalNativeBuild/cmake/debug/mips64 --target native-kit-android}
  [1/1] Re-running CMake...
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/.externalNativeBuild/cmake/debug/mips64
  [1/1] Linking CXX shared library ../../../../build/intermediates/cmake/debug/obj/mips64/libnative-kit-android.so
  FAILED: : && /Users/paulo/Developer/android-ndk-r13b/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang++  -target mips64el-none-linux-android -gcc-toolchain /Users/paulo/Developer/android-ndk-r13b/toolchains/mips64el-linux-android-4.9/prebuilt/darwin-x86_64 --sysroot=/Users/paulo/Developer/android-ndk-r13b/platforms/android-21/arch-mips64 -fPIC -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -Wa,--noexecstack -Wformat -Werror=format-security -fno-exceptions -fno-rtti  -O0 -fno-limit-debug-info  -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--no-undefined -Wl,-z,noexecstack -Qunused-arguments -Wl,-z,relro -Wl,-z,now -shared -Wl,-soname,libnative-kit-android.so -o ../../../../build/intermediates/cmake/debug/obj/mips64/libnative-kit-android.so CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/curl-android/mips64  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips64  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/zlib-android/mips64 -lm "/Users/paulo/Developer/android-ndk-r13b/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips64/libgnustl_static.a" && :
  CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o: In function `Java_com_prsolucoes_nativekit_HttpClient_get':
  /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/src/main/cpp/HttpClient_JNI.cpp:32: undefined reference to `NK::HttpClient::get(std::string)'
  clang++: error: linker command failed with exit code 1 (use -v to see invocation)
  ninja: build stopped: subcommand failed.


* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output.

BUILD FAILED

Total time: 2.075 secs
```