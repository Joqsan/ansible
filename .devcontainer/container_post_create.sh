#!/bin/bash

sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

pushd /home/joqsan
git clone --single-branch --branch dev-environment https://github.com/Joqsan/ansible.git
pushd ansible
ansible-playbook local.yml
popd
popd