echo -e "\e[31mConfigure Rabbitmq repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[31mConfigure Rabbitmq repose[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[31mConfiguring Nodejs repos\e[0m"
yum install rabbitmq-server -y

echo -e "\e[31mInstall Rabbitmq Server\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[31Add Rabbitmq Application user\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"