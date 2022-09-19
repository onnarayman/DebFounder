#!/bin/sh -e

# Checking system
if
	[[ "$(uname -a)" =~ "i686 Linux"$ ]]
		then
			echo "You're using iSH!"
		else
			echo "You're not using iSH!"
				exit
fi

# Installing dependencies
echo Installing dependencies..
if
	[[ "$(apk -e info curl)" == "" ]]
		then
			apk add curl
fi

if
	[[ "$(apk -e info wget)" == "" ]]
		then
			apk add wget
fi

if
	[[ "$(apk -e info xz)" == "" ]]
		then
			apk add xz
fi

if
	[[ "$(apk -e info zstd)" == "" ]]
		then
			apk add zstd
fi

# Getting repo url
echo "Enter your desired repo":
read user_repo
var1=`if [[ $user_repo =~ "/"$ ]]; then echo ${user_repo%?}; else echo $user_repo; fi`

#Getting package list
try1="${var1}/Packages.bz2"
try2="${var1}/Packages.gz"
try3="${var1}/Packages.xz"
try4="${var1}/Packages.zst"
try5="${var1}/dists/stable/main/binary-iphoneos-arm/Packages.bz2"
try6="${var1}/dists/stable/main/binary-iphoneos-arm/Packages.gz"
try7="${var1}/dists/stable/main/binary-iphoneos-arm/Packages.xz"
try8="${var1}/dists/stable/main/binary-iphoneos-arm/Packages.zst"
try9="${var1}/dists/iphoneos-arm64/1800/main/binary-iphoneos-arm/Packages.bz2"
try10="${var1}/dists/iphoneos-arm64/1800/main/binary-iphoneos-arm/Packages.gz"
try11="${var1}/dists/iphoneos-arm64/1800/main/binary-iphoneos-arm/Packages.xz"
try12="${var1}/dists/iphoneos-arm64/1800/main/binary-iphoneos-arm/Packages.zst"
echo Getting package list..
curl -k -L -f -O $try1 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try2 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try3 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try4 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try5 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try6 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try7 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try8 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try9 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try10 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try11 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null || curl -k -L -f -O $try12 -H 'X-Machine: iPhone14,3' -H 'X-Unique-ID: da39a3ee5e6b4b0d3255bfef95601890afd80709' 2> /dev/null ||
RESULT=$?
if
	[ "$RESULT" == "" ]
		then
			echo "Succeed getting package list"
		else
			echo "Failed getting package list. Check your repo!"
			exit
fi

#Decompressing package file
bzip2 -d Packages.bz2 2> /dev/null || gzip -d Packages.gz 2> /dev/null || xz -d Packages.xz || zstd -d Packages.zst && rm -f Packages.zst

#Getting package name
echo "Enter your package name: (It's better if you entered the bundle id!)"
read user_package

#Finding deb path
var2=`grep -i -A 9 $user_package Packages || rm -f Packages`
var3=`echo $var2 | sed -e 's/.*Filename: \(.*\).deb.*/\1/'`

#Getting link
var4="${var1}/${var3}.deb"

#Downloading deb file
echo "Downloading deb file.."
wget -r $var4 --header='X-Machine: iPhone6,1' --header='X-Unique-ID: 8843d7f92416211de9ebb963ff4ce28125932878' 2> /dev/null && echo Succeed downloading deb file || echo Failed to download deb file

#Cleaning cache
echo "Cleaning cache.."; rm -f Packages