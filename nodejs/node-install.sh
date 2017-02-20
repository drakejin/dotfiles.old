#/bin/sh


#node 를 만들어 보자
sudo mkdir /usr/local/develop
sudo chown -R likemilk:likemilk develop
mkdir /usr/local/develop/language

wget https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-x64.tar.xz
tar xvf node-v6.9.4-linux-x64.tar.xz
mv node-v6.9.4-linux-x64.tar.xz /usr/local/develop/language/node-6.9.4




npm install -g bower gulp eslint eslint-cli babel-cli
