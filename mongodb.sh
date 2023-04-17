yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod

## edit file and replace 127.0.0.1 with 0.0.0.0