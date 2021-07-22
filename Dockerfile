FROM php:7.0-apache

RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo Europe/Moscow > /etc/timezone \
    && dpkg-reconfigure tzdata \
    && apt-get update \
    && apt-get install -y wget g++ zlib1g-dev curl libicu-dev libmagickwand-dev libpq-dev libzip-dev libmemcached-dev curl libbz2-dev libpng-dev gettext libfreetype6-dev libmcrypt-dev libjpeg-dev libjpeg62-turbo-dev libldap2-dev pngquant optipng pngcrush libjpeg-progs jpegoptim gifsicle libimage-exiftool-perl libwebp-dev pngnq advancecomp imagemagick libpq-dev && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
    && pecl install -o -f redis memcache \
    && rm -rf /tmp/pear \
    && docker-php-source extract \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) imagick intl ldap gd bz2 mysqli sockets bcmath gettext pdo_mysql pdo pdo_pgsql pgsql zip \
    && docker-php-ext-enable redis memcache mysqli \
    && docker-php-source delete \
    && touch /usr/local/etc/php/conf.d/tzone.ini \
    && printf '[PHP]\ndate.timezone = "Europe/Moscow"\n' > /usr/local/etc/php/conf.d/tzone.ini \
    && date \
    && wget https://getcomposer.org/composer-stable.phar -O /usr/local/bin/composer && chmod +x /usr/local/bin/composer \
    && date \
    && a2enmod rewrite \
    && a2enmod suexec \
    && a2enmod headers