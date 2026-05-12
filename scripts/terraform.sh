#!/bin/bash

echo "Removing old HashiCorp repo..."
sudo rm -f /etc/apt/sources.list.d/hashicorp.list

echo "Updating packages..."
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl

echo "Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

sudo chmod a+r /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com noble main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Updating apt repositories..."
sudo apt update -y

echo "Installing Terraform..."
sudo apt-get install terraform -y

echo "Terraform version:"
terraform version
