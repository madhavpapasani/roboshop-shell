echo -e "\e[31mConfiguring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[31mInstall Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[31mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[31mCreate application directory\e[0m"
rm -ef /app &>>/tmp/roboshop.log &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[31mDownload application content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mExtract application content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mInstall Nodejs dependencies\e[0m" &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log &>>/tmp/roboshop.log
echo -e "\e[31mSetup SystemD service\e[0m"
cp home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[31mStart user service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log
echo -e "\e[31mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[31mLoad schema\e[0m"
mongo --host mongodb-dev.madhavdevops.store </app/schema/user.js &>>/tmp/roboshop.log