echo -e "\e[31mDisable MYSQL Default version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[31mCopy mysql repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
echo -e "\e[31mInstall Mysql community version\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log
echo -e "\e[31mStart mysql service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
echo -e "\e[31mSetup mysql password\e[0m"
mysql_secure_installation --set-root-pass $1 &>>/tmp/roboshop.log
