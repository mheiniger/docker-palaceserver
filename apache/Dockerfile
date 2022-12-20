FROM php:8.2-apache

LABEL org.opencontainers.image.source=https://github.com/mheiniger/docker-palaceserver

RUN pecl install apcu \
	&& pecl install xdebug \
	&& docker-php-ext-enable apcu xdebug

RUN groupadd --gid 1000 palace \
    && useradd --uid 1000 --gid palace --shell /bin/bash --create-home palace

# uncomment for debugging php
# ADD docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d

ADD sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf

ENV APACHE_RUN_USER=palace
ENV APACHE_RUN_GROUP=palace

RUN mkdir -p /app/run/avatars \
    mkdir -p /app/run/media \
	mkdir -p /app/run/webservice/propStorage
RUN	chown -R palace:palace /app/run

USER palace
