script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo Input MySQL Root Password Missing
  exit
fi

${script_path}Disable MySQL 8 Version <<<<<<<<\e[0m"
dnf module disable mysql -y
${script_path}Copy MySQL Repo File <<<<<<<<\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
${script_path}Install MySQL <<<<<<<<\e[0m"
yum install mysql-community-server -y
${script_path}Start MySQL <<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld
${script_path}Reset MySQL Password <<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass $mysql_root_password


