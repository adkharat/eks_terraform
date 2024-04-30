#!/bin/bash

#Update the machine
sudo apt-get update

#install OpenJDK 17
sudo apt-get install openjdk-11-jre -y

#check Installed Java Version
java -version

# Download Jenkins keyring
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to package sources
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

#sudo ufw allow 8080
#allow OpenSSH
#sudo ufw allow OpenSSH
#enable the firewall
#sudo ufw enable

# Update package lists
sudo apt-get update

# Install Jenkins package
sudo apt-get install jenkins -y

#enable the Jenkins service to start at boot with the command:
sudo systemctl enable jenkins

#start the Jenkins service with the command:
sudo systemctl start jenkins

#check the status of the Jenkins service using the command:
#sudo systemctl status jenkins

sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists
sudo apt-get update

#install the latest version of Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Create the docker group if it does not exist
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER

# Log in to the new docker group (to avoid having to log out / log in again; but if not enough, try to reboot):
newgrp docker

#restart the docker
sudo systemctl restart docker

# Change the permissions of docker socket to be able to connect to the docker daemon
sudo chmod 666 /var/run/docker.sock

# Check if docker can be run without root
#docker run hello-world