source common.sh
component=catalogue
nodejs
echo -e "${color}Copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
echo -e "${color}Install mongodb client${nocolor}"
yum install mongodb-org-shell -y &>>$log_file
echo -e "${color}Load schema${nocolor}" &>>$log_file
mongo --host mongodb-dev.madhavdevops.store <${app_path}/schema/$component.js &>>$log_file
