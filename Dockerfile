FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install nginx-full mariadb-server wget
RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json
RUN mysql_install_db
COPY ./srcs/php.ini ./etc/php/7.3/fpm/php.ini
COPY ./srcs/default ./etc/nginx/sites-available/default
COPY ./srcs/index.html /var/www/html/default
COPY ./srcs/info.php /var/www/html/default
CMD nginx -g 'daemon off;' && service php-fpm7.3 start && service php-fpm start && service nginx start && service mysql start && status && nginx -t
EXPOSE 80