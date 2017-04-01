# ERROR

```
native-kit/build/native-kit-android (master) $ ./gradlew build 
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
:app:compileDebugAidl
:app:compileDebugRenderscript
:app:generateDebugBuildConfig
:app:generateDebugResValues
:app:generateDebugResources
:app:mergeDebugResources
:app:processDebugManifest
:app:processDebugResources
:app:generateDebugSources
:app:incrementalDebugJavaCompilationSafeguard
:app:javaPreCompileDebug
:app:compileDebugJavaWithJavac
:app:compileDebugJavaWithJavac - is not incremental (e.g. outputs have changed, no previous execution, etc.).
:app:generateJsonModelDebug
:app:externalNativeBuildDebug
Build native-kit-android mips64
ninja: no work to do.
Build native-kit-android mips
[1/1] Linking CXX shared library ../../../../build/intermediates/cmake/debug/obj/mips/libnative-kit-android.so
FAILED: : && /Users/paulo/Developer/android-ndk-r13b/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang++  -target mipsel-none-linux-android -gcc-toolchain /Users/paulo/Developer/android-ndk-r13b/toolchains/mipsel-linux-android-4.9/prebuilt/darwin-x86_64 --sysroot=/Users/paulo/Developer/android-ndk-r13b/platforms/android-14/arch-mips -fPIC -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -mips32 -Wa,--noexecstack -Wformat -Werror=format-security -fno-exceptions -fno-rtti  -O0 -fno-limit-debug-info  -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--no-undefined -Wl,-z,noexecstack -Qunused-arguments -Wl,-z,relro -Wl,-z,now -shared -Wl,-soname,libnative-kit-android.so -o ../../../../build/intermediates/cmake/debug/obj/mips/libnative-kit-android.so CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/curl-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/zlib-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../generator/native-kit-android/tmp/local/mips -lnative-kit -lcurl -lssl -lcrypto -lz -lm "/Users/paulo/Developer/android-ndk-r13b/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips/libgnustl_static.a" && :
/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips/libcrypto.a(ui_openssl.o): In function `read_string_inner':
ui_openssl.c:(.text+0x214): undefined reference to `signal'
ui_openssl.c:(.text+0x3c8): undefined reference to `tcsetattr'
ui_openssl.c:(.text+0x4a0): undefined reference to `tcsetattr'
/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips/libcrypto.a(ui_openssl.o): In function `open_consol
e':
ui_openssl.c:(.text+0x89c): undefined reference to `tcgetattr'
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.
:app:externalNativeBuildDebug FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:externalNativeBuildDebug'.
> Build command failed.
  Error while executing process /Users/paulo/Library/Android/sdk/cmake/3.6.3155560/bin/cmake with arguments {--build /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/.externalNativeBuild/cmake/debug/mips --target native-kit-android}
  [1/1] Linking CXX shared library ../../../../build/intermediates/cmake/debug/obj/mips/libnative-kit-android.so
  FAILED: : && /Users/paulo/Developer/android-ndk-r13b/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang++  -target mipsel-none-linux-android -gcc-toolchain /Users/paulo/Developer/android-ndk-r13b/toolchains/mipsel-linux-android-4.9/prebuilt/darwin-x86_64 --sysroot=/Users/paulo/Developer/android-ndk-r13b/platforms/android-14/arch-mips -fPIC -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -mips32 -Wa,--noexecstack -Wformat -Werror=format-security -fno-exceptions -fno-rtti  -O0 -fno-limit-debug-info  -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--no-undefined -Wl,-z,noexecstack -Qunused-arguments -Wl,-z,relro -Wl,-z,now -shared -Wl,-soname,libnative-kit-android.so -o ../../../../build/intermediates/cmake/debug/obj/mips/libnative-kit-android.so CMakeFiles/native-kit-android.dir/src/main/cpp/HttpClient_JNI.cpp.o -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/curl-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/zlib-android/mips  -L/Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../generator/native-kit-android/tmp/local/mips -lnative-kit -lcurl -lssl -lcrypto -lz -lm "/Users/paulo/Developer/android-ndk-r13b/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips/libgnustl_static.a" && :
  /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips/libcrypto.a(ui_openssl.o): In function `read_string_inner':
  ui_openssl.c:(.text+0x214): undefined reference to `signal'
  ui_openssl.c:(.text+0x3c8): undefined reference to `tcsetattr'
  ui_openssl.c:(.text+0x4a0): undefined reference to `tcsetattr'
  /Users/paulo/Developer/workspaces/cpp/native-kit/build/native-kit-android/app/../../../vendor/openssl-android/mips/libcrypto.a(ui_openssl.o): In function `open_console':
  ui_openssl.c:(.text+0x89c): undefined reference to `tcgetattr'
  clang++: error: linker command failed with exit code 1 (use -v to see invocation)
  ninja: build stopped: subcommand failed.


* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output.

BUILD FAILED

Total time: 7.184 secs
```