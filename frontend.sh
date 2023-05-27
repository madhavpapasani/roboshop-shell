echo -e "\e[31mHello in Red Color\e[0m"
yum install nginx -y
echo -e "\e[31mHello in Red Color\e[0m"

echo -e "\e[31mHello in Red Color\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[31mHello in Red Color\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[31mHello in Red Color\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#we need to config config file
systemctl enable nginx
systemctl restart nginx

