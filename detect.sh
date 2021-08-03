#!/bin/sh

A1=$(readelf -h /bin/sh | grep "Machine:" | awk -F: '{ print $2}' | xargs) 
A2=$(readelf -A /bin/sh | grep "Tag_CPU_arch:" | awk -F: '{ print $2}' | xargs)  
ARCH="$A1$A2"

echo "Search: >$ARCH<"

case "$A1$A2" in
	*X86-64*)
		ARCH="amd64"
		;;
	"PowerPC64")
		ARCH="ppc64le"
		;;
	"IBM S/390")
		ARCH="s390x"
		;;
    AArch64*)
		ARCH="arm64"
		;;
	*)
		echo "Sorry, unknown architecture"
        exit 1
		;;
esac

echo "Arch: $ARCH"
mkdir -p ./build
cp ./dist/temporal-server_linux_$ARCH/* ./build
cp ./dist/tctl_linux_$ARCH/* ./build
cp ./dist/temporal-cassandra-tool_linux_$ARCH/* ./build
cp ./dist/temporal-sql-tool_linux_$ARCH/* ./build