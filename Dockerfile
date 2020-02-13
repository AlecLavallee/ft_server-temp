FROM debian:buster
LABEL maintainer Alelaval <alelaval@student.42.fr>

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx mariadb-server mariadb-client wget
RUN apt-get install -y php-fpm php-mysql 
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz
RUN tar -zxvf latest-fr_FR.tar.gz
RUN mv wordpress /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN chmod -R 755 /var/www/html/wordpress/
RUN rm latest-fr_FR.tar.gz
RUN rm var/www/html/index.nginx-debian.html && rm /var/www/html/wordpress/wp-config-sample.php
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpMyAdmin
RUN rm phpMyAdmin-4.9.0.1-all-languages.tar.gz

COPY ./srcs/php.ini ./etc/php/7.3/fpm/php.ini
COPY ./srcs/default ./etc/nginx/sites-available/default
COPY ./srcs/wordpress ./etc/nginx/sites-available/wordpress
COPY ./srcs/info.php ./var/www/html
COPY ./srcs/wp-config.php ./var/www/html/wordpress/wp-config.php
COPY ./srcs/localhost.crt /etc/ssl/certs/localhost.crt
COPY ./srcs/localhost.key /etc/ssl/private/localhost.key
COPY ./srcs/db_wordpress db_wordpress
COPY ./srcs/service.sh service.sh
COPY ./srcs/db.sh db.sh
COPY ./srcs/start.sh start.sh

RUN sh db.sh

CMD ["bash", "./start.sh"]
