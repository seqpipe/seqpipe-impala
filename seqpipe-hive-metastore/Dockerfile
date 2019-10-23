FROM seqpipe/seqpipe-cdh-base:latest

USER root

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y postgresql postgresql-client \
    postgresql-contrib

# Run the rest of the commands as the ``postgres`` user created by the 
# ``postgres`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
ADD ./postgresql/pg_hba.conf /etc/postgresql/10/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
# CMD ["/usr/lib/postgresql/10/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"

# HIVE
USER root

ENV HIVE_VER 3.1.2

ENV HIVE_HOME /opt/hive
ENV HIVE_CONF_DIR $HIVE_HOME/conf

ENV PATH $HIVE_HOME/bin:$PATH

RUN wget https://www-us.apache.org/dist/hive/hive-${HIVE_VER}/apache-hive-${HIVE_VER}-bin.tar.gz

RUN tar -xvf apache-hive-$HIVE_VER-bin.tar.gz -C ..; \
    mv ../apache-hive-$HIVE_VER-bin $HIVE_HOME
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O $HIVE_HOME/lib/postgresql-42.2.5.jar

RUN useradd -p $(echo "hive" | openssl passwd -1 -stdin) hive; \
    groupadd hdfs; \
    usermod -a -G hdfs hive;

EXPOSE 9083

ADD ./supervisor/supervisord.conf /etc/

ADD ./hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD ./hadoop/conf/hdfs-site.xml /etc/hadoop/conf/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

# ADD ./hive/conf/hive-site.xml /opt/hive/conf
RUN rm -f $HIVE_CONF_DIR/hive-site.xml $HIVE_CONF_DIR/hive-log4j2.properties
ADD ./hive/conf/hive-site.xml $HIVE_HOME/conf/
ADD ./hive/psql/fix_default_location.sql /

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
