script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1


if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit
fi


print_head "Install Python"
yum install python36 gcc python3-devel -y
print_head "Add Application User"
useradd ${app_user}
print_head "Create App Dir"
rm -rf /app
mkdir /app
print_head "Download App Content"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
print_head "Extract App Content"
cd /app
unzip /tmp/payment.zip
print_head "Install Dependencies"
pip3.6 install -r requirements.txt
print_head "Setup SystemD Service"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp /payment.service /etc/systemd/system/payment.service
print_head "Start Payment Service"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
