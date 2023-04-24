FROM rofeitosa/bacula-base:13.0.2

LABEL maintainer="rofeitosa"

# RUN apt-get install -y bacula-cloud-storage-common bacula-cloud-storage-s3

RUN for i in `ls /opt/bacula/bin`; do if test -z /usr/sbin/$i; then ln -s /opt/bacula/bin/$i /usr/sbin/$i; fi; done 

EXPOSE 9103/tcp

ENTRYPOINT ["bacula-sd"]

CMD ["-f", "-c", "/opt/bacula/etc/bacula-sd.conf"]