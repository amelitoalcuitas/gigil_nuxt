FROM php:8.3-fpm-alpine
RUN apk update
RUN apk add --no-cache git bash libzip-dev vim pcre-dev linux-headers ${PHPIZE_DEPS}
RUN docker-php-ext-install bcmath zip mysqli pdo_mysql
  
RUN pecl install redis && docker-php-ext-enable redis
COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN printf '[PHP]\ndate.timezone = "Asia/Tokyo"\n' > /usr/local/etc/php/conf.d/tzone.ini
COPY ./docker/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

RUN apk del pcre-dev ${PHPIZE_DEPS}
COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Add Composer to container
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN rm -rf /var/cache/apk/*

# Setup xDebug
ARG ENABLE_XDEBUG
ADD ./docker/php/scripts/configure-xdebug.sh /configure-xdebug.sh
RUN ["chmod", "+x", "/configure-xdebug.sh"]
RUN /configure-xdebug.sh


# Setup Opcache
ARG OPCACHE_VALIDATE_TIMESTAMPS
ADD ./docker/php/scripts/configure-opcache.sh /configure-opcache.sh
RUN ["chmod", "+x", "/configure-opcache.sh"]
RUN /configure-opcache.sh

# Update Git directory permission
RUN git config --global --add safe.directory /var/www/backend
