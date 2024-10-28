FROM php:8.1-fpm AS stage-0

# Копіюємо composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Копіюємо ваш проект
COPY . /var/www/html

WORKDIR /var/www/html

# Запускаємо установку залежностей
RUN composer install --optimize-autoloader --no-dev