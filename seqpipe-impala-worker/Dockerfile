FROM seqpipe/seqpipe-impala-base:CDH6.3.2

USER root

RUN mkdir -p /var/run/hdfs-sockets; \
    chown hdfs.hadoop /var/run/hdfs-sockets
RUN mkdir -p /data/dn; \
     chown hdfs.hadoop /data/dn

ADD ./hadoop/conf/yarn-site.xml /etc/hadoop/conf/

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

VOLUME ["/data"]

WORKDIR /

EXPOSE 21000 21050 22000 23000 25000 27000 28000
EXPOSE 9864 50075 50010 50020
EXPOSE 4242 2049 111


ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
