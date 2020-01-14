FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install nginx-full
COPY 
CMD ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' && nginx -g 'daemon off;' && service nginx start
EXPOSE 80
