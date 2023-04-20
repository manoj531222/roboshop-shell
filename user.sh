script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[33m>>>>>>>>> Setup NodeJS repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m>>>>>>>>> Install NodeJS <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[33m>>>>>>>>> Add application User<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[33m>>>>>>>>> Create App Directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[33m>>>>>>>>> Download App Content <<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[33m>>>>>>>>> Unzip App Content <<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[33m>>>>>>>>> Install Npm <<<<<<<<\e[0m"
npm install

echo -e "\e[33m>>>>>>>>> Copy user SystemD file <<<<<<<<\e[0m"
cp ${script_path}/user.service /etc/systemd/system/user.service

echo -e "\e[33m>>>>>>>>> Start user Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[33m>>>>>>>>> Copy MongoDB repo <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m>>>>>>>>> Install MongoDB Client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[33m>>>>>>>>> Load Schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.mdevops333.online </app/schema/user.js

