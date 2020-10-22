FROM amd64/ubuntu:18.04

USER root

ENV CDH_VERSION 6.3.2
ENV TZ UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update --fix-missing && \
    apt-get -y dist-upgrade

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update --fix-missing && \
    apt-get -y dist-upgrade

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get install -y git wget gnupg2 supervisor less vim \
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

RUN groupadd -r -g 1000 supergroup
RUN useradd -r -u 1000 -g 1000 user0
RUN useradd -r -u 1001 -g 1000 user1
RUN useradd -r -u 1002 -g 1000 user2
RUN useradd -r -u 1003 -g 1000 user3
RUN useradd -r -u 1004 -g 1000 user4
RUN useradd -r -u 1005 -g 1000 user5
