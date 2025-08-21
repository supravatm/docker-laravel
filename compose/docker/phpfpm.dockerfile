FROM php:8.4-fpm

RUN apt-get update && apt-get install -y  \
    --no-install-recommends \
    && docker-php-ext-install pdo pdo_mysql pdo_mysql mysqli

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Composer to the PATH
ENV PATH="/usr/local/bin:$PATH"