FROM debian:bullseye

LABEL maintainer="rofeitosa"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
		apt-utils \
		apt-transport-https \
		gnupg \
		ca-certificates \
		wget \
		ntp

RUN cd /tmp
RUN wget -qO- https://www.bacula.org/downloads/Bacula-4096-Distribution-Verification-key.asc \
	| gpg --dearmor | tee /usr/share/keyrings/bacula-archive-keyring.gpg

COPY files/Bacula-Community.list /etc/apt/sources.list.d/Bacula-Community.list

RUN apt-get update \
&& apt-get -y install \
		bacula-postgresql \
		bacula-common \
		bacula-console \
		bacula-client \
		bacula-aligned \
		bacula-cloud-storage-common \
		bacula-cloud-storage-s3 

RUN for i in `ls /opt/bacula/bin`; do ln -s /opt/bacula/bin/$i /usr/sbin/$i; done
RUN rm /etc/apt/sources.list.d/Bacula-Community.list


