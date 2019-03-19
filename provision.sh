#!/bin/bash

#assign variables
ACTION=${1}
VERSION=1.0.0
function initilizeUpdateStartPackage(){
# update all system packages
sudo yum update -y
# Install the Nginx software package
sudo amazon-linux-extras install nginx1.12 -y
#Configure nginx to automatically start
sudo chkconfig nginx on
#Copy from s3 to web document root directory
sudo aws s3 cp s3://anutamang-assignment-4/index.html /usr/share/nginx/html
#start the Nginx
sudo service nginx start
}

function remove(){
# stop the Nginx
sudo service nginx stop
# delete the files in the root directory
sudo rm -rf /usr/share/nginx/html/*
#Uninstall the Nginx package'
sudo yum remove nginx -y

}
function display_version(){
echo $VERSION
}

function display_help(){
cat << EOF
Usage: ${0} { -h|--help|-v|--version|-r|--remove} <filename>
OPTIONS:
	-h |--help Display the command help
	-v |--version Display the version
	-r |--remove Remove file
Examples:
	Display help:
		$ ${0} -h
EOF
}

case "$ACTION" in
	-h| --help)
		display_help
		;;
	-v| --version)
		display_version
		;;
	-r| --remove)
		remove
		;;
	*)
	initilizeUpdateStartPackage
	exit 1
esac
