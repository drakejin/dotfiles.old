sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# 이 타이밍에 root 의 홈 디렉토리로 가지므로 exit 눌러준다.
echo 'exit명령어를 입력해 다음 페이스로 진행하세요'
sudo -i


curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


echo 'PATH=$PATH:/usr/local/bin' >> ~/.bashrc 
source ~/.bashrc


docker-compose --version
echo "루트사용자가 docker-compose 의 권한을 획득하였습니다."
exit


