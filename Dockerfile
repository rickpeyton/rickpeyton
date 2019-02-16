FROM wordpress:5.0.3-php7.3-apache
COPY ./config/ports.conf /etc/apache2/ports.conf
COPY . /var/www/html
