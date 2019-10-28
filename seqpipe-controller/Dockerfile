FROM seqpipe/seqpipe-impala-base:latest

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y hadoop-yarn-resourcemanager

ADD ./hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD ./hadoop/conf/hdfs-site.xml /etc/hadoop/conf/
ADD ./hadoop/conf/yarn-site.xml /etc/hadoop/conf/

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

VOLUME ["/data"]

WORKDIR /

EXPOSE 8020 9870
EXPOSE 8032 8033 8030 8031 8088 8090
EXPOSE 21000 21050 22000 23000 23020 24000 25000 25010 25020 26000

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]