FROM ubuntu:latest

MAINTAINER Paulo Coutinho

# install dependencies
RUN apt-get update && apt-get install -y \
     build-essential \
     git \
	 python \
     wget \
	 nano \
	 curl \
	 unzip \
	 m4 \
	 autoconf \
	 autotools-dev \
	 automake \
	 libtool-bin \
	 cmake
	 
RUN apt-get clean

# base paths
ENV BASE_DIR=/opt
RUN mkdir -p ${BASE_DIR}

# android ndk
RUN wget https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip -O ${BASE_DIR}/android-ndk-r13b-linux-x86_64.zip
RUN unzip ${BASE_DIR}/android-ndk-r13b-linux-x86_64.zip -d ${BASE_DIR}

ENV ANDROID_NDK_ROOT=${BASE_DIR}/android-ndk-r13b

# move to project home
WORKDIR /native-kit

CMD [bash]
