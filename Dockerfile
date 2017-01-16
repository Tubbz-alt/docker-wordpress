FROM wordpress:php7-fpm-alpine
FROM nginx:alpine
MAINTAINER Antergos Developers

RUN apk --no-cache add curl git openssh bash
RUN adduser -D ubuntu

##
# Make sure db container has time to startup
##
RUN sed -i 's|#!/bin/bash|&\nsleep 15|g' /usr/local/bin/docker-entrypoint.sh

##
# Install wp-cli
##
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp-cli \
	&& chmod +rx /usr/local/bin/wp-cli

##
# Install composer
##
RUN curl -L https://getcomposer.org/installer -o composer-setup.php \
	&& php composer-setup.php \
	&& rm  composer-setup.php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/composer