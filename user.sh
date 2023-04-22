script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user

func_nodejs
${script_path}Copy MongoDB repo <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
${script_path}Install MongoDB Client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y
${script_path}Load Schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.mdevops333.online </app/schema/user.js

