color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"
stat_check(){
   if [ $1 -eq 0 ]; then
           echo SUCCESS
    else
            echo FAILURE
    fi
}
app_presetup(){
  echo -e "${color}Add application user${nocolor}"
  if [ $? -eq 1 ]; then
       echo SUCCESS
       useradd roboshop &>>$log_file
  fi
       stat_check $?
       echo -e "${color}Create application directory${nocolor}"
       rm -rf ${app_path} &>>${log_file}
       mkdir ${app_path} &>>${log_file}

      stat_check $?

        echo -e "${color}Download application content${nocolor}"
        curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
        cd ${app_path}

       stat_check $?

        echo -e "${color}Extract application content${nocolor}"
        unzip /tmp/${component}.zip &>>$log_file

       stat_check $?

}
 systemd_setup(){
   echo -e "${color}Setup systemD service${nocolor}"
     cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>$log_file
      sed -i -e "s/roboshop_app_password/$roboshop_app_password/" /etc/systemd/system/${component}.service
    stat_check $?

   echo -e "${color}Start ${component} service${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}

    stat_check $?

  }
nodejs() {
  echo -e "${color}Configuring Nodejs repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  echo -e "${color}Install Nodejs${nocolor}"
  yum install nodejs -y &>>$log_file

  app_presetup

  cd ${app_path}
  echo -e "${color}Install Nodejs dependencies${nocolor}"
  npm install &>>$log_file

  systemd_setup
}

mongo_schema_setup(){
  echo -e "${color}Copy mongodb repo${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
  echo -e "${color}Install mongodb client${nocolor}"
  yum install mongodb-org-shell -y &>>$log_file
  echo -e "${color}Load schema${nocolor}" &>>$log_file
  mongo --host mongodb-dev.madhavdevops.store <${app_path}/schema/${component}.js &>>$log_file
}

mysql_schema_setup(){
    echo -e "${color}Install Mysql client${nocolor}"
    yum install mysql -y &>>${log_file}
    echo -e "${color}Load Schema${nocolor}"
    mysql -h mysql-dev.madhavdevops.store -uroot -pRoboShop@1 <${app_path}/schema/${component}.sql &>>${log_file}
}

maven() {
  echo -e "${color}Install Maven${nocolor}"
  yum install maven -y &>>${log_file}

 app_presetup

  cd ${app_path}
  echo -e "${color}Download Maven Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  mysql_schema_setup

  systemd_setup
}

python() {
  echo -e "${color}Install Python${nocolor}"
  yum install python36 gcc python3-devel -y &>>${log_file}

  stat_check $?

  app_presetup

  echo -e "${color}Install Application Dependencies${nocolor}"
  cd /app
  pip3.6 install -r requirements.txt &>>${log_file}
  stat_check $?

  systemd_setup

}