FROM amd64/ubuntu:18.04

USER root

ENV CDH_VERSION 6.3.2

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update --fix-missing && \
    apt-get -y dist-upgrade


RUN DEBIAN_FRONTEND=noninteractive \
	apt-get install -y wget gnupg2 supervisor less vim \
    inetutils-ping telnet net-tools apt-utils \
    openjdk-8-jdk-headless \
    ldap-auth-client nscd \
    && apt purge openjdk-11*


RUN echo \
    "deb [arch=amd64] http://archive.cloudera.com/cdh6/${CDH_VERSION}/ubuntu1804/apt bionic-cdh${CDH_VERSION} contrib" > \
    /etc/apt/sources.list.d/cdh.list

RUN wget \
    https://archive.cloudera.com/cdh6/${CDH_VERSION}/ubuntu1804/apt/archive.key \
    && apt-key add archive.key

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update --fix-missing

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y zookeeper \
        hadoop-hdfs-datanode \
        hadoop-hdfs-namenode \
        hadoop-hdfs-nfs3