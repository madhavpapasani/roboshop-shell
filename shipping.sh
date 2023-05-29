echo -e "\e[31mInstall Maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log
echo -e "\e[31mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[31mCreate application directory\e[0m"
rm -ef a/app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[31mDownloading application content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mExtract application content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mDownload Maven Dependencies\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log
echo -e "\e[31mSetup SystemD file\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[31mInstall Mysql client\e[0m"
yum install mysql -y &>>/tmp/roboshop.log
echo -e "\e[31mLoad Schema\e[0m"
mysql -h mysql-dev.madhavdevops.store -uroot -pRoboShop@1 </app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[31mStart shipping service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log