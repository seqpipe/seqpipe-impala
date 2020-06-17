FROM seqpipe/seqpipe-impala-base:CDH6.3.2

USER root

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

WORKDIR /

EXPOSE 4242 2049 111

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
