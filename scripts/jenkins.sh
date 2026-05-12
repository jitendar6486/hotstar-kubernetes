#!/bin/bash

# Jenkins installation script

sudo apt update -y

# Install Java
sudo apt install -y fontconfig openjdk-17-jre gnupg curl

# Create keyrings directory
sudo mkdir -p /etc/apt/keyrings

# Add Jenkins GPG key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/jenkins.gpg

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins.gpg] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update packages
sudo apt update -y

# Install Jenkins
sudo apt install -y jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Check Jenkins status
sudo systemctl status jenkins --no-pager
