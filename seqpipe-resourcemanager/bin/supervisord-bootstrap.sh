#!/bin/bash

set -e

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_REPLICATION/${SP_REPLICATION}/g" /etc/hadoop/conf/hdfs-site.xml

sed -i \
    "s/SP_RESOURCEMANAGER/0.0.0.0/g" /etc/hadoop/conf/yarn-site.xml

mkdir -p /data/dn/
chown hdfs:hadoop -R /data/dn

mkdir -p /data/nn
chown hdfs:hadoop -R /data/nn


echo -e	"YARN Resource Manager..."

supervisorctl start yarn-resourcemanager
./wait-for-it.sh localhost:8088 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "YARN Resource Manager not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "YARN Resource Manager:                     http://${SP_REOURCEMANAGER}:8088"
echo -e "--------------------------------------------------------------------------------\n\n"
