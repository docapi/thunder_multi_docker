FROM php:7.2-apache

# Install PHP extension dependencies (if any)
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    libxml2-dev \
    git \
    zip \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev

RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy PHP configuration
# Edit docker/php.ini and customize it to your needs
COPY php.ini /usr/local/etc/php/php.ini

# Copy custom command docker-php-pecl-install
COPY docker-php-pecl-install /usr/local/bin/

# Install PHP extensions
RUN docker-php-ext-install pdo
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install xml
RUN docker-php-ext-install gd && \
    docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

# Install PECL extensions
#RUN docker-php-pecl-install <package_name-version> (versions available in PECL repository allowed)

# If you are using XDebug, this might be useful, if not, ignore it
# You additionally will have to customize docker/xdebug-ini-overrides.ini file to your needs
#RUN docker-php-pecl-install xdebug-2.5.4
#COPY docker/xdebug-ini-overrides.ini /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini

# Configure Apache VHOSTS
COPY apache.conf /etc/apache2/sites-available/first.conf
RUN a2ensite first.conf
COPY site1_apache.conf /etc/apache2/sites-available/site1.conf
RUN a2ensite site1.conf

RUN a2dissite 000-default

#RUN sed -ri -e 's!/var/www/html!/var/www/html/docroot!g' /etc/apache2/sites-available/*.conf
#RUN sed -ri -e 's!/var/www/html!/var/www/html/docroot!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Activate Apache modules
RUN a2enmod rewrite
RUN service apache2 restart

# Set the workdir
WORKDIR /var/www/html