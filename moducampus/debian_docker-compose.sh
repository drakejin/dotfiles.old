sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88


dpkg --print-architecture


# amd64
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
             stable"

# armhf
sudo add-apt-repository \
       "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
             stable"
   
sudo apt-get update -y

sudo apt-get install -y docker-ce

sudo service docker start
sudo usermod -a -G docker ubuntu
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
exit
docker-compose --version""""


