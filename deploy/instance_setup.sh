#!/usr/bin/env bash

SECRET_DJANGO_KEY="AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
REPO_PATH=/home/ec2-user/LabDevops-front/

# Docker and system setup
dnf update -y
dnf install -y git docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

DOCKER_CONFIG=${DOCKER_CONFIG:-/home/ec2-user/.docker}
mkdir -p "$DOCKER_CONFIG"/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-linux-x86_64 -o "$DOCKER_CONFIG/cli-plugins/docker-compose"
chmod +x "$DOCKER_CONFIG/cli-plugins/docker-compose"

# Setup project
cd /home/ec2-user || exit 1
git clone https://github.com/polirritmico/LabDevops-front.git
chown -R ec2-user:ec2-user "$REPO_PATH"
cd LabDevops-front || exit 1

## Get the AWS public DNS
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PUBLIC_DNS=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-hostname)

# Set the .env
cat <<EOF >.env
DJANGO_DEBUG=False
DJANGO_SECRET_KEY="$SECRET_DJANGO_KEY"
DJANGO_ALLOWED_HOSTS="$PUBLIC_DNS"
EOF
chown ec2-user:ec2-user "$REPO_PATH"/.env

# Run as ec2-user
su - ec2-user -c "cd $REPO_PATH && docker compose up web-production watchtower"
