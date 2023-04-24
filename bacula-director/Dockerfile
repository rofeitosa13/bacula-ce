FROM rofeitosa/bacula-base:13.0.2

LABEL maintainer="rofeitosa"

EXPOSE 9101/tcp

ENTRYPOINT ["bacula-dir"]

CMD ["-f", "-c", "/opt/bacula/etc/bacula-dir.conf"]

