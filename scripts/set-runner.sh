#!/bin/bash

sudo apt update && sudo apt install -y curl tar jq
sudo mkdir actions-runner 
cd actions-runner 
curl -o actions-runner-linux-x64-2.316.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.316.1/actions-runner-linux-x64-2.316.1.tar.gz tar xzf 
./actions-runner-linux-x64-2.316.1.tar.gz
./config.sh --url https://github.com/<your-username>/<your-repo> --token <generated-token>
sudo ./svc.sh 
install sudo ./svc.sh 
start sudo ./svc.sh status