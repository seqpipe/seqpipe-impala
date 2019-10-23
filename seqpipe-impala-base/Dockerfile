FROM seqpipe/seqpipe-cdh-base:latest

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y impala \
        impala-server \
        impala-shell \
        impala-catalog \
        impala-state-store

RUN groupadd supergroup; \ 
    usermod -a -G supergroup impala; \
    usermod -a -G hdfs impala; \
    usermod -a -G supergroup hive; \
    usermod -a -G hdfs hive

ADD ./impala/conf/core-site.xml /etc/impala/conf/
ADD ./impala/conf/hdfs-site.xml /etc/impala/conf/
ADD ./impala/conf/hive-site.xml /etc/impala/conf/
