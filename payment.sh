script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1


if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit
fi


${script_path}Install Python <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
${script_path}Add Application User <<<<<<<<\e[0m"
useradd ${app_user}
${script_path}Create App Dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app
${script_path}Download App Content <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
${script_path}Extract App Content <<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip
${script_path}Install Dependencies <<<<<<<<\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[36m>>>>>>>>>Setup SystemD Service <<<<<<<<\e[0m"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service
${script_path}Start Payment Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
