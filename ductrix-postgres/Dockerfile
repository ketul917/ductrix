FROM postgres
MAINTAINER Kevin Patel <kevin@ductrix.com>
COPY ductdb.sql /docker-entrypoint-initdb.d/
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
