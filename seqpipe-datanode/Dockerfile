FROM seqpipe/seqpipe-cdh-base:latest

USER root

RUN mkdir -p /var/run/hdfs-sockets; \
    chown hdfs.hadoop /var/run/hdfs-sockets
RUN mkdir -p /data/dn/
RUN chown hdfs.hadoop /data/dn

ADD ./hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD ./hadoop/conf/hdfs-site.xml /etc/hadoop/conf/

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

VOLUME ["/data"]

WORKDIR /

EXPOSE 50075 50010 50020

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
