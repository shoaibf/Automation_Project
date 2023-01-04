#!/bin/bash

echo "Updating Packages ..."

myname=Mohammed
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket=upgrad-mohammed

sudo apt update -y
dpkg -s apache2 &> /dev/null

    if [ $? -ne 0 ]

        then
            echo "Installing apache2..."
            sudo apt-get update
            sudo apt-get install apache2

        else
            echo    "apache2 is installed.."
    fi

	if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'active (running)' | wc -l) -ne 0 ]

		then
			echo "Apache2 is running..."
		else
			echo "Starting Apache2..."
			sudo systemctl start apache2
	fi

echo "Archiving Logs..."

tar cvf /tmp/$myname-httpd-logs-$timestamp.tar /var/log/apache2/*.log

echo "Copying files to S3..."

aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar