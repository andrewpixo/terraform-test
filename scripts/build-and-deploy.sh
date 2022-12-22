#! /bin/bash
#init AWS resources
cd ./architecture/staging && terraform init && terraform apply -auto-approve

#grab terraform output
FRONTEND_KEY=$(cd ../../architecture/staging && terraform output --raw frontend_key)
FRONTEND_IP=$(cd ../../architecture/staging && terraform output --raw frontend_ip)
BACKEND_KEY=$(cd ../../architecture/staging && terraform output --raw backend_key)
BACKEND_IP=$(cd ../../architecture/staging && terraform output --raw backend_ip)


#build applications and push to docker repository
cd ../../frontend && docker build -t frontend --build-arg API_URL="http://$BACKEND_IP" . && docker save frontend > ../frontend.tar
cd ../backend && docker build -t backend . && docker save backend > ../backend.tar


#write ssh keys to files
cd ../
echo $FRONTEND_KEY > ./frontend_key
echo $BACKEND_KEY > ./backend_key

#ssh into ec2 instances and pull docker images
scp -i ./frontend_key -o StrictHostKeyChecking=no ./frontend.tar ubuntu@$FRONTEND_IP:~/
scp -i ./frontend_key -o StrictHostKeyChecking=no ./scripts/install-docker.sh ubuntu@$FRONTEND_IP:~/
ssh -i  ./frontend_key -o StrictHostKeyChecking=no  ubuntu@"$FRONTEND_IP" "sh ./install-docker.sh"
ssh -i  ./frontend_key -o StrictHostKeyChecking=no  ubuntu@"$FRONTEND_IP" "docker load < frontend.tar && docker run -d -p 80:80 frontend"

scp -i ./backend_key -o StrictHostKeyChecking=no ./backend.tar ubuntu@$BACKEND_IP:~/
scp -i ./backend_key -o StrictHostKeyChecking=no ./scripts/install-docker-backend.sh ubuntu@$BACKEND_IP:~/
ssh -i  ./backend_key -o StrictHostKeyChecking=no  ubuntu@"$BACKEND_IP" "sh ./install-docker-backend.sh"

#remove ssh keys
rm ./frontend_key
rm ./backend_key

echo "frontend: $FRONTEND_IP"
echo "backend: $BACKEND_IP"