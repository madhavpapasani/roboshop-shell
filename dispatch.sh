echo -e "\e[31mInstall golang\e[0m"
yum install golang -y

echo -e "\e[31mAdd Application user\e[0m"
useradd roboshop

echo -e "\e[31mCreate Application directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31mDownload Application content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[31mExtract Application content\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[31mInstall Application dependencies\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[31mSetup SystemD service\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[31mStart dispatch service\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch