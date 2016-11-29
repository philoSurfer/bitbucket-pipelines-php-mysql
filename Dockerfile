FROM debian:stretch-slim
MAINTAINER Damien Debin <damien.debin@smartapps.fr>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN \
 apt-get update &&\
 apt-get -y --no-install-recommends install locales apt-utils &&\
 echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
 locale-gen en_US.UTF-8 &&\
 /usr/sbin/update-locale LANG=en_US.UTF-8 &&\
 echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
 echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
 apt-get -y --no-install-recommends install ca-certificates gnupg git subversion php7.0-mysql php-cli php7.0-sqlite php7.0-mcrypt php7.0-curl php7.0-intl php7.0-gettext php7.0-json php7.0-geoip php7.0-apcu php7.0-gd php7.0-imagick php7.0-xdebug php7.0-xmlrpc php-xml php-zip imagemagick openssh-client curl software-properties-common gettext zip mysql-server mysql-client apt-transport-https ruby python python3 perl php7.0-memcached memcached &&\
 curl -sSL https://deb.nodesource.com/setup_6.x | bash - &&\
 apt-get -y --no-install-recommends install nodejs &&\
 apt-get autoclean && apt-get clean && apt-get autoremove

RUN \
 sed -ri -e "s/^variables_order.*/variables_order = \"EGPCS\"/g" /etc/php/7.0/cli/php.ini

RUN \
 curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin &&\
 curl -sSL https://phar.phpunit.de/phpunit.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit  &&\
 curl -sSL http://codeception.com/codecept.phar -o /usr/bin/codecept && chmod +x /usr/bin/codecept &&\
 npm install --no-color --production --global gulp-cli webpack mocha grunt &&\
 rm -rf /root/.npm /root/.composer /tmp/* /var/lib/apt/lists/*
