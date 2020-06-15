FROM seqpipe/seqpipe-cdh-base:CDH6.3.2

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y zookeeper \
        hadoop-hdfs-nfs3 ldap-auth-client nscd

ADD ./hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD ./hadoop/conf/hdfs-site.xml /etc/hadoop/conf/


ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

WORKDIR /

EXPOSE 4242 2049 111

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
