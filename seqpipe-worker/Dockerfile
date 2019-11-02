FROM seqpipe/seqpipe-impala-base:latest

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y zookeeper \
        hadoop-yarn-nodemanager

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

EXPOSE 9864 9866 50075 50010 50020
EXPOSE 21000 21050 22000 23000 25000 27000 28000
EXPOSE 8042 45454 8080 4040 7077
EXPOSE 32000-32032


ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
