FROM amd64/ubuntu:18.04

USER root

ENV CDH_VERSION 6.3.0

RUN apt-get update --fix-missing && \ 
	apt-get install -y wget gnupg2 supervisor

RUN wget \
    https://archive.cloudera.com/cm6/${CDH_VERSION}/ubuntu1804/apt/cloudera-manager.list \
    && mv cloudera-manager.list /etc/apt/sources.list.d/ \
    && wget https://archive.cloudera.com/cm6/6.3.0/ubuntu1604/apt/archive.key \
    && apt-key add archive.key


RUN apt-get update --fix-missing
