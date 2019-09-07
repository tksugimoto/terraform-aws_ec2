#!/bin/bash -ex

# Amazon ECS における Docker の基本 - Amazon Elastic Container Service
# https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/docker-basics.html

sudo yum update -y

sudo amazon-linux-extras install docker

sudo service docker start

# ec2-user を docker グループに追加すると、sudo を使用せずに Docker コマンドを実行できます。
sudo usermod -a -G docker ec2-user


# Install Docker Compose | Docker Documentation
# https://docs.docker.com/compose/install/

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
