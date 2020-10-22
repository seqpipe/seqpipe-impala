FROM seqpipe/seqpipe-cdh-base:CDH6.3.2udf

USER root

COPY zookeeper/* /etc/zookeeper/conf/

EXPOSE 2181
WORKDIR /

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh


ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

