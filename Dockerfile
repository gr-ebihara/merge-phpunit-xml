FROM composer:1.8.5
WORKDIR /tmp/merge-phpunit-xml
ADD merge-phpunit-xml.php composer.json composer.lock /tmp/merge-phpunit-xml/
RUN /usr/bin/composer install --no-dev
ADD https://github.com/humbug/box/releases/download/3.7.0/box.phar /usr/bin/box
ADD box.json .
RUN php /usr/bin/box compile

FROM php:7.2.15
WORKDIR /root/
COPY --from=0 /tmp/merge-phpunit-xml/merge-phpunit-xml.phar .
ADD docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
