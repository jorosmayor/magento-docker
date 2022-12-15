FROM php:8.1-fpm

# Instalación de pauqetes necesarios de php
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd bcmath ctype curl dom fileinfo iconv intl json mbstring openssl pcre pdo_mysql soap sockets sodium xmlwriter xsl zip

# Instalación Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia de claves para la instalación de Magento
COPY ./auth.json /root/.composer/auth.json

# Limitación de memoria utilizada por PHP a inifito
RUN echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

WORKDIR /var/www/html

EXPOSE 9000