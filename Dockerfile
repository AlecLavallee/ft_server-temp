FROM debian:buster
RUN apt-get update && apt-get upgrade && apt-get install -y nginx vim mariadb-server mariadb-client wget
RUN apt-get install -y php-fpm php-mysql
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpMyAdmin
RUN rm phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN chmod -R 755 /var/www/html/
COPY ./srcs/index.html /var/www/html/index.html
COPY ./srcs/info.php /var/www/html/info.php
COPY ./srcs/default /etc/nginx/sites-available/localhost
#RUN cd /tmp
#RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
CMD nginx -g 'daemon off;' && service nginx start && service php7.3-fpm start && service mysql start
