color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"
nodejs() {
  echo -e "${color}Configuring Nodejs repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  echo -e "${color}Install Nodejs${nocolor}"
  yum install nodejs -y &>>$log_file
  echo -e "${color}Add application user${nocolor}"
  useradd roboshop &>>$log_file
  echo -e "${color}Create application directory${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path} &>>$log_file
  echo -e "${color}Download application content${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  cd ${app_path}
  echo -e "${color}Extract application content${nocolor}"
  unzip /tmp/$component.zip &>>$log_file
  cd ${app_path}
  echo -e "${color}Install Nodejs dependencies${nocolor}"
  npm install &>>$log_file
  echo -e "${color}Setup systemD service${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
  echo -e "${color}Start Catalogue service${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
}