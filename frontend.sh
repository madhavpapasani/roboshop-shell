echo -e "\e[31mInstalling Nginx server\e[0m"
yum install nginx -y

echo -e "\e[32mRemoving App Content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mDownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[34mExtracting frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[34mUpdate Frontend Configuration\e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35mStarting Nginx Service\e[0m"
systemctl reload nginx
systemctl enable nginx
systemctl restart nginx