echo -e "\e[31mConfiguring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[31mInstall Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[31mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[31mCreate application directory\e[0m"
rm -ef /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[31mDownload application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e "\e[31mExtract application content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mInstall Nodejs dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[31mSetup systemD service\e[0m"
cp /root/roboshop-shell/catalogue.service vim /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[31mStart Catalogue service\e[0m" &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
echo -e "\e[31mCopy mongodb repo\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "\e[31mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[31mLoad schema\e[0m"
mongo --host mongodb-dev.madhavdevops.store </app/schema/catalogue.js &>>/tmp/roboshop.log
