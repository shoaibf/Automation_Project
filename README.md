# Automation_Project
Upgrad Course Assignment

This is a bash script which will perform the below automation tasks on a ubuntu OS 

1. Perform an update of the package details and the package list at the start of the script.
2. Install the apache2 package if it is not already installed.
3. Ensure that the apache2 service is running. 
4. Ensure that the apache2 service is enabled.
5. Create a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and place the tar into the /tmp/ directory. 
6. The script will run the AWS CLI command and copy the archive to the s3 bucket. 

# Pre requisites:

#Make the script executible

chmod  +x  /root/Automation_Project/automation.sh

#switch to root user with sudo su

sudo  su
./root/Automation_Project/automation.sh

#or run with sudo privileges
sudo ./root/Automation_Project/automation.sh


You can install AWS CLI manually before writing and testing the script. 

# Installing awscli 

sudo apt update
sudo apt install awscli