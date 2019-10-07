#!/bin/bash

set -e

sed -i \
    "s/ZOOKEEPER/${ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml

mkdir -p /data/dn/
chown hdfs:hadoop -R /data/dn

mkdir -p /data/lib/hadoop-hdfs/cache/hdfs/dfs/name
chown hdfs:hadoop -R /data/lib/hadoop-hdfs

echo -e "\n---------------------------------------"

if [[ ! -e /data/lib/hadoop-hdfs/cache/hdfs/dfs/name/current ]]; then
    	echo -e	"Initiating HDFS NameNode..."
	/etc/init.d/hadoop-hdfs-namenode init
	rc=$?
    	if [ $rc -ne 0 ]; then
	    	echo -e	"HDFS initiation ERROR!"
    	else
        	echo -e	"HDFS successfully initiaded!"
    	fi
fi

echo -e	"Starting NameNode..."
supervisorctl start hdfs-namenode

/wait-for-it.sh localhost:8020 -t 120
/wait-for-it.sh localhost:9870 -t 120

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - NameNode:                     http://localhost:9870"
echo -e "--------------------------------------------------------------------------------\n\n"
