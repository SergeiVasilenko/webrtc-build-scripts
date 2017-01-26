#!/bin/sh
SRC_PATH="webrtc/src"
LIB_BORINGSSL="libboringssl.cr.so"
LIB_CPPSHARED="libc++_shared.so"
LIB_JINGLE="libjingle_peerconnection_so.so"
LIB_PROTOBUF="libprotobuf_lite.cr.so"
BUILD_TYPE_RELEASE="Release"
BUILD_TYPE_DEBUG="Debug"
# BUILD_TYPE="Release"
ARCH_ARM="out_android_arm"
ARCH_ARM64="out_android_arm64"
ARCH_X64="out_android_x64"
ARCH_X86="out_android_x86"
LIBS_PATH="libs"
echo "Start creating zip file with source path $SRC_PATH"
echo "Remove $LIBS_PATH and ${LIBS_PATH}.zip"
rm -rf $LIBS_PATH
rm "${LIBS_PATH}.zip"
echo "Create $LIBS_PATH"
mkdir $LIBS_PATH
for BUILD_TYPE in $BUILD_TYPE_DEBUG $BUILD_TYPE_RELEASE
do
	for ARCH in $ARCH_ARM $ARCH_ARM64 $ARCH_X64 $ARCH_X86
	do
		CURRENT_PATH="${SRC_PATH}/${ARCH}/${BUILD_TYPE}"
		OUTPUT_PATH="${LIBS_PATH}/${BUILD_TYPE}/${ARCH}"
		echo "Copy from $CURRENT_PATH to $OUTPUT_PATH"
		mkdir -p $OUTPUT_PATH
		cp $CURRENT_PATH/$LIB_BORINGSSL $OUTPUT_PATH/$LIB_BORINGSSL
		cp $CURRENT_PATH/$LIB_CPPSHARED $OUTPUT_PATH/$LIB_CPPSHARED
		cp $CURRENT_PATH/$LIB_JINGLE $OUTPUT_PATH/$LIB_JINGLE
		cp $CURRENT_PATH/$LIB_PROTOBUF $OUTPUT_PATH/$LIB_PROTOBUF
	done	
done
echo "Start zip"
zip -r "${LIBS_PATH}.zip" $LIBS_PATH
echo "Finished"