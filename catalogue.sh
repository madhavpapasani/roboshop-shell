component=catalogue
color="\e[31m"
nocolor="\e[0m"
echo -e "${color}Configuring Nodejs repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "${color}Install Nodejs${nocolor}"
yum install nodejs -y
echo -e "${color}Add application user${nocolor}"
useradd roboshop
echo -e "${color}Create application directory${nocolor}"
rm -rf /app
mkdir /app
echo -e "${color}Download application content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip
cd /app
echo -e "${color}Extract application content${nocolor}"
unzip /tmp/$component.zip
cd /app
echo -e "${color}Install Nodejs dependencies${nocolor}"
npm install
echo -e "${color}Setup systemD service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service
echo -e "${color}Start Catalogue service${nocolor}"
systemctl daemon-reload
systemctl enable $component
systemctl restart $component
echo -e "${color}Copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "${color}Install mongodb client${nocolor}"
yum install mongodb-org-shell -y
echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.madhavdevops.store </app/schema/$component.js
