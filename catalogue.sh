echo -e "\e[31mConfiguring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[31mInstall Nodejs\e[0m"
yum install nodejs -y
echo -e "\e[31mAdd application user\e[0m"
useradd roboshop
echo -e "\e[31mCreate application directory\e[0m"
mkdir /app
echo -e "\e[31mDownload application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[31mExtract application content\e[0m"
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[31mInstall Nodejs dependencies\e[0m"
npm install
echo -e "\e[31mSetup systemD service\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[31mStart Catalogue service\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[31mCopy mongodb repo\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[31mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31mLoad schema\e[0m"
mongo --host mongodb-dev.madhavdevops.store </app/schema/catalogue.js
