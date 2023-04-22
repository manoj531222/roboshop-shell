script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo Input MySQL Root Password Missing
  exit
fi

${script_path}Install Maven <<<<<<<<\e[0m"
yum install maven -y
${script_path}Create App User
useradd ${app_user}
${script_path}Create App Directory
rm -rf /app
mkdir /app
${script_path}Download App Content
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
${script_path}Extract App Content
cd /app
unzip /tmp/shipping.zip
${script_path}Download Maven Dependencies
mvn clean package
mv target/shipping-1.0.jar shipping.jar
${script_path}Install MySQL
yum install mysql -y
${script_path}Load Schema
mysql -h mysql-dev.mdevops333.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
${script_path}Setup SystemD Service
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
${script_path}Start Shipping Service
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping