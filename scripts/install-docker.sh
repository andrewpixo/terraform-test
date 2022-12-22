#! /bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" 
sudo apt-get update
sudo apt-get install -y docker-ce 
sudo systemctl start docker 
sudo systemctl enable docker 
sudo groupadd docker 
sudo usermod -aG docker ubuntu
docker load < frontend.tar
docker run -d -p 80:80 frontend