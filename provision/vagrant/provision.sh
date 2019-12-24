#!/usr/bin/env bash
sudo apt-get -y install unzip
sudo unzip /provision/archive/rubear.zip -d /app

sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password password'
sudo apt-get install -y mysql-server

mysql -uroot -ppassword -e "CREATE DATABASE IF NOT EXISTS latex_rubear";
sudo service mysql restart

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common

sudo apt-get install -y php7.1 php7.1-fpm
sudo apt-get install -y php7.1-mysql
sudo apt-get install -y mcrypt php7.1-mcrypt
sudo apt-get install -y php7.1-cli php7.1-curl php7.1-mbstring php7.1-xml php7.1-mysql
sudo apt-get install -y php7.1-json php7.1-cgi php7.1-gd php-imagick php7.1-bz2 php7.1-zip php7.1-bcmath
sudo apt-get install -y php7.1-xdebug
cat << EOF > /etc/php/7.1/fpm/conf.d/20-xdebug.ini
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.remote_autostart=1
xdebug.idekey=PHPSTORM
EOF
sudo service php7.1-fpm restart

sudo apt-get install -y nginx
sudo cp /provision/nginx/rubear.conf /etc/nginx/sites-enabled/rubear.conf
sudo service nginx restart

mysql -uroot -ppassword latex_rubear < /app/latex_rubear.sql
touch /app/www/log/access.log
touch /app/www/log/error.log