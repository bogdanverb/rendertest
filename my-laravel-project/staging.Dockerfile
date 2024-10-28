# Використовуємо офіційний PHP-образ з Apache
FROM php:8.1-apache

# Встановлюємо необхідні розширення PHP
RUN docker-php-ext-install pdo pdo_mysql

# Встановлюємо Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Встановлюємо залежності Laravel
COPY . /var/www/html
WORKDIR /var/www/html
RUN composer install --optimize-autoloader --no-dev

# Створюємо і кешуємо Laravel ключ, конфігурацію і маршрути
RUN php artisan key:generate
RUN php artisan config:cache
RUN php artisan route:cache

# Налаштовуємо права доступу для Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Відкриваємо порт для сервера Apache
EXPOSE 80
