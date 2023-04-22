app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")



func_nodejs(){
  echo -e "\e[36m>>>>>>>>> Configuring NodeJS repos <<<<<<<<\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  echo -e "\e[36m>>>>>>>>> install NodeJS <<<<<<<<\e[0m"
  yum install nodejs -y
  echo -e "\e[36m>>>>>>>>> add app user <<<<<<<<\e[0m"
  useradd ${app_user}
  echo -e "\e[36m>>>>>>>>> create app dir <<<<<<<<\e[0m"
  rm -rf /app
  mkdir /app
  echo -e "\e[36m>>>>>>>>> download app content <<<<<<<<\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  cd /app
  echo -e "\e[36m>>>>>>>>> unzip app content <<<<<<<<\e[0m"
  unzip /tmp/${component}.zip
  echo -e "\e[36m>>>>>>>>> install node js dependencies <<<<<<<<\e[0m"
  npm install
  echo -e "\e[36m>>>>>>>>> create app dir <<<<<<<<\e[0m"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  echo -e "\e[36m>>>>>>>>> start cart srevice <<<<<<<<\e[0m"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}


}
