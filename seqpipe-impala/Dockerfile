FROM seqpipe/seqpipe-impala-base:latest

USER root

ADD ./supervisor/supervisord.conf /etc/

ADD ./bin/supervisord-bootstrap.sh /
ADD ./bin/wait-for-it.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]