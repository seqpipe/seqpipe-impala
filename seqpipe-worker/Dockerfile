FROM seqpipe/seqpipe-impala-base:latest

USER root

RUN mkdir -p /var/run/hdfs-sockets; \
    chown hdfs.hadoop /var/run/hdfs-sockets
RUN mkdir -p /data/dn; \
     chown hdfs.hadoop /data/dn

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

VOLUME ["/data"]

WORKDIR /

EXPOSE 9864 50075 50010 50020
EXPOSE 21000 21050 22000 23000 25000

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
