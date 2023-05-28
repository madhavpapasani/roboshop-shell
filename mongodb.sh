echo -e "\e[31mCopy Mondodb file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb.log
echo -e "\e[32mInstall mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/mongodb.log
echo -e "\e[32mUpdate mongodb listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[33mStarting mongodb service\e[0m"
systemctl enable mongod &>>/tmp/mongodb.log
systemctl start mongod &>>/tmp/mongodb.log