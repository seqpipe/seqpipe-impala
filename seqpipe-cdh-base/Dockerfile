FROM amd64/ubuntu:18.04

USER root

ENV CDH_VERSION 6.3.0

RUN apt-get update --fix-missing && \ 
	apt-get install -y wget gnupg2 supervisor less vim inetutils-ping


RUN echo \
    "deb [arch=amd64] http://archive.cloudera.com/cdh6/${CDH_VERSION}/ubuntu1804/apt bionic-cdh${CDH_VERSION} contrib" > \
    /etc/apt/sources.list.d/cdh.list

RUN wget \
    https://archive.cloudera.com/cdh6/${CDH_VERSION}/ubuntu1804/apt/archive.key \
    && apt-key add archive.key


RUN apt-get update --fix-missing

RUN apt -y dist-upgrade
