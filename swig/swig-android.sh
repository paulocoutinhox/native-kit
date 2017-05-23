swig -c++ -java \
	-package com.prsolucoes.nativekit \
	-outdir ../projects/native-kit-android/app/src/main/java/com/prsolucoes/nativekit/ \
	-o ../projects/native-kit-android/app/src/main/cpp/native_kit_wrap.cpp \
	NativeKit.i
