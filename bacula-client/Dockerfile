FROM rofeitosa/bacula-base:13.0.2

LABEL maintainer="rofeitosa"

EXPOSE 9102/tcp

ENTRYPOINT ["bacula-fd"]

CMD ["-f", "-c", "/opt/bacula/etc/bacula-fd.conf"]