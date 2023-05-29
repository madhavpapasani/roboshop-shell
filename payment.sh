echo -e "\e[31mInstall Python\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[31mAdd application user\e[0m"
useradd roboshop

echo -e "\e[31mCreate application directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31mDownload Application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[31mExtract Application content\e[0m"
unzip /tmp/payment.zip

echo -e "\e[31mInstall Application Dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[31mSetup SystemD service\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[31mStart payment service\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

