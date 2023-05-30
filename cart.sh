echo -e "\e[31mConfiguring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[31mInstall Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[31mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[31mCreate application directory\e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[31mDownload application content\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mExtract application content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mInstall Nodejs dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[31msetup systemD service\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[31mStart cart service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log