FROM php:8.3-zts as base

RUN pecl install parallel \
      && docker-php-ext-enable parallel

RUN apt update \
    && apt install -y htop time \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
CMD ["/usr/sbin/php-fpm8.3","--nodaemonize","--fpm-config","/etc/php/8.3/fpm/php-fpm.conf"]