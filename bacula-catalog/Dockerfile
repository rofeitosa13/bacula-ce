FROM rofeitosa/bacula-base:13.0.2 AS common

LABEL maintainer="rofeitosa"

FROM postgres:13-bullseye

ENV POSTGRES_INITDB_ARGS '--encoding=SQL_ASCII --lc-collate=C --lc-ctype=C'

COPY --from=common /opt/bacula/scripts/make_postgresql_tables /docker-entrypoint-initdb.d/make_postgresql_tables

COPY --from=common /opt/bacula/scripts/grant_postgresql_privileges /docker-entrypoint-initdb.d/grant_postgresql_privileges

RUN { \
	echo '#!/bin/bash'; \
	echo 'sh /docker-entrypoint-initdb.d/make_postgresql_tables --username=$POSTGRES_USER'; \
	echo 'sh /docker-entrypoint-initdb.d/grant_postgresql_privileges --username=$POSTGRES_USER'; \
} >> /docker-entrypoint-initdb.d/deploy_database.sh \
&& chmod +x /docker-entrypoint-initdb.d/deploy_database.sh \
&& chown postgres. /docker-entrypoint-initdb.d/deploy_database.sh

RUN chown -R postgres. /docker-entrypoint-initdb.d/*

EXPOSE 5432/tcp
