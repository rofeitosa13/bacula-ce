FROM rofeitosa/bacula-base:13.0.2

LABEL maintainer="rofeitosa"

ENV DEBIAN_FRONTEND=noninteractive

# O apt-key add será descontinuado após o Debian 11 e Ubuntu 22.04
# RUN wget -qO - https://www.bacula.org/downloads/baculum/baculum.pub | apt-key add -

RUN wget -qO - https://www.bacula.org/downloads/baculum/baculum.pub | gpg --dearmor \
	| tee /usr/share/keyrings/baculum-archive-keyring.gpg

COPY files/baculum.list /etc/apt/sources.list.d/baculum.list

RUN apt-get update \
    && apt-get install -y \
		baculum-common \
		baculum-api \
		baculum-api-apache2 \
		php-fpm \
		sudo \
		supervisor

COPY files/sudoers-baculum /etc/sudoers.d/sudoers-baculum 

COPY files/supervisord.conf /etc/supervisor/supervisord.conf

COPY files/api.conf /usr/share/baculum/htdocs/protected/API/Config/api.conf

RUN chown -R www-data:www-data /etc/baculum/

#Dando permissão ao usuário Web Server para alterar os arquivos de configuração do Bacula
RUN groupadd -g 1000 bdocker \
    && usermod -aG bdocker www-data

RUN mkdir -p /run/php

RUN a2enmod rewrite

RUN a2ensite baculum-api

RUN apt-get clean

EXPOSE 9096/tcp

ENTRYPOINT ["/usr/bin/supervisord"]
