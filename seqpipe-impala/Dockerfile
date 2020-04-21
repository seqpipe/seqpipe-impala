FROM seqpipe/seqpipe-impala-base:CDH6.3.2

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y zookeeper 

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

VOLUME ["/data"]

WORKDIR /

EXPOSE 21000 21050 22000 23000 25000 27000 28000


ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
