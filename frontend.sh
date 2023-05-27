echo -e "\e[31mInstalling Nginx server\e[0m"
yum install nginx -y
echo -e "\e[31mRemoving App Content\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[32mDownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[33mExtracting frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#we need to config config file

echo -e "\e[34Starting Nginx Service\e[0m"
systemctl enable nginx
systemctl restart nginx

