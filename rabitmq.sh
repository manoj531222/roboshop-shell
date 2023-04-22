script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit
fi

${script_path}Setup ErLang Repos${script_path}
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
${script_path}Setup RabbitMQ Repos${script_path}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
${script_path}Install ErLang & RabbitMQ${script_path}
yum install erlang rabbitmq-server -y
${script_path}Start RabbitMQ Service${script_path}
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
${script_path}Add Application User in RabbtiMQ${script_path}
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"


