echo -e "\e[36m>>>>>>>>> repo file as a rpm <<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[36m>>>>>>>>> Enable Redis 6.2 <<<<<<<<\e[0m"
dnf module enable redis:remi-6.2 -y
echo -e "\e[36m>>>>>>>>> Install Redis <<<<<<<<\e[0m"
yum install redis -y
echo -e "\e[36m>>>>>>>>> change the config <<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
cho -e "\e[36m>>>>>>>>> Start & Enable Redis Service <<<<<<<<\e[0m"
systemctl enable redis
systemctl start redis