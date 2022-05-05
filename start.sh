#!/bin/bash -ex
# Start script for Rimworld called from docker

URL=`curl https://github.com/TastyLollipop/OpenWorld/releases|grep LinuxX64|head -1|awk -F\" '{print $2}'`
RemoteVersion=`printf ${URL}|awk -F/ '{print $6}'`
containerIP=`hostname -i`

cd /rimworld
# Does version exist?
if [ ! -f "version.txt" ]
then
	printf "0.0.0\n" > version.txt
fi
LocalVersion=`cat version.txt`

# Pull if not updated
if [ ${RemoteVersion} != ${LocalVersion} ]
then
	#Pull new package
	wget  https://github.com/${URL}
	unzip -o LinuxX64.zip
	unzip -o 'Core & DLCs.zip'
	chmod 755 'Open World Server'
	printf "${RemoteVersion}\n" > version.txt
fi

# Update config with IP
if [ -f "Server Settings.txt" ]
then
	sed -i "s/^Server Local IP:.*/Server Local IP: ${containerIP}/g" 'Server Settings.txt'
fi

# Run server
./"Open World Server"
