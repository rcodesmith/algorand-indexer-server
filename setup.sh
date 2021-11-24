#!/bin/sh

#
# Setup script for VM
#

# Exit on any error
set -e

# Install docker: https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker compose

wget https://github.com/docker/compose/releases/download/v2.1.0/docker-compose-linux-x86_64
sudo mv ./docker-compose-linux-x86_64 /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose

# Create data directory for algorand, which will be shared among node & indexer
sudo mkdir -p /var/algorand/data

# Copy node-config.json to data directory
sudo cp config.json /var/algorand/config.json

# Bootstrap Algorand node data directory on VM from algorand-node docker image
sudo docker-compose run algorand-node sh -c "cp -R /root/node/data/* /var/algorand/data/"
sudo docker-compose run algorand-node sh -c "cp /var/algorand/config.json /var/algorand/data/"

# Start everything up
sudo docker-compose up -d algorand-node
