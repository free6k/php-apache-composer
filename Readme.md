# PHP-APACHE-COMPOSER
The docker image with all popular modules for PHP frameworks as Yii2 or Laravel. Including composer for install packages

[Docker Hub](https://hub.docker.com/r/free6k/php-apache-composer)

## How to use
### Run as apache daemon on port 80
```
docker run --rm -p "80:80" -v "$(pwd):/var/www/html" free6k/php-apache-composer
```
### Run for single file or line code
```
docker run --rm -it -v "$(pwd):/var/www/html" free6k/php-apache-composer php -r "echo 'Hi from php-apache-composer' . PHP_EOL;"
```
### Run composer
```
docker run --rm -it -v "$(pwd):/var/www/html" free6k/php-apache-composer composer -V
```
### Run in docker-compose, apache will be listen port 80
```
version: "3.7"
services:
  php:
    image: free6k/php-apache-composer:latest
    ports:
      - '80:80'
    volumes:
      - ./:/var/www/html:delegated
```
### Fast install and run Yii 2 framework
```
cd <to empty directory>

docker run --rm -it -v "$(pwd):/var/www/html" free6k/php-apache-composer composer create-project --prefer-dist yiisoft/yii2-app-basic .

docker run --rm -it -p '8080:8080' -v "$(pwd):/var/www/html" free6k/php-apache-composer ./yii serve 0.0.0.0
```
Go to http://localhost:8080

## Modules
```
# docker run --rm -it free6k/php-apache-composer php -m

[PHP Modules]
bcmath
bz2
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
gettext
hash
iconv
imagick
intl
json
ldap
libxml
mbstring
memcache
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
posix
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zip
zlib
```