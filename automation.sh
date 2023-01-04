#!/bin/bash

echo "Updating Packages ..."

myname=Mohammed
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket=upgrad-mohammed
tablefile=/var/www/html/inventory.html

sudo apt update -y
dpkg -s apache2 &> /dev/null

    if [ $? -ne 0 ]

        then
            echo "Installing apache2..."
            sudo apt-get update
            sudo apt-get install apache2

        else
            echo    "Apache2 is installed.."
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


file_size_kb=`du -k "//tmp//${myname}-httpd-logs-${timestamp}.tar" | cut -f1`

echo "Creating Inventory log table"

	if [ ! -e /var/www/html/inventory.html ]; then
	   echo "<table ><tr><th>Log Type</th><th>Time Created</th><th>Type</th><th>Size</th></tr> \
	   <tr><td>httpd-logs</th><th>$timestamp</th><th>tar</th><th>$file_size_kb</th></tr>" > /var/www/html/inventory.html
	else
	   echo "<tr><td>httpd-logs</td><td>$timestamp</td><td>tar</td><td>$file_size_kb kb</td></tr>" >> /var/www/html/inventory.html
	fi

	if [ ! -e /etc/cron.d/automation ];	then
			echo "30 4 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
	fi