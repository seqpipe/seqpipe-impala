set -e

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_REPLICATION/${SP_REPLICATION}/g" /etc/hadoop/conf/hdfs-site.xml

sed -i \
    "s/SP_RESOURCEMANAGER/${SP_RESOURCEMANAGER}/g" /etc/hadoop/conf/yarn-site.xml

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/SP_HIVEMETASTORE/${SP_HIVEMETASTORE}/g" /etc/impala/conf/hive-site.xml
sed -i \
    "s/SP_REPLICATION/${SP_REPLICATION}/g" /etc/impala/conf/hdfs-site.xml


sed -i \
    "s/SP_IMPALA_STATESTORE/${SP_IMPALA_STATESTORE}/g" /etc/default/impala
sed -i \
    "s/SP_IMPALA_CATALOG/${SP_IMPALA_CATALOG}/g" /etc/default/impala


mkdir -p /data/dn/
chown hdfs:hadoop -R /data/dn

mkdir -p /data/lib/hadoop-hdfs/cache/hdfs/dfs/name
chown hdfs:hadoop -R /data/lib/hadoop-hdfs

/wait-for-it.sh ${SP_NAMENODE}:8020 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  HDFS namenode ${SP_NAMENODE}:8020 not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

/wait-for-it.sh ${SP_NAMENODE}:9870 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  HDFS namenode ${SP_NAMENODE}:9870 not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

echo -e "\n---------------------------------------"
echo -e	"Starting DataNode..."
supervisorctl start hdfs-datanode

/wait-for-it.sh localhost:9864 -t 120

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - DataNode:                     http://localhost:9864"
echo -e "--------------------------------------------------------------------------------\n\n"


# supervisorctl start yarn-nodemanager
# ./wait-for-it.sh localhost:8042 -t 60
# rc=$?
# if [ $rc -ne 0 ]; then
#     echo -e "\n--------------------------------------------"
#     echo -e "YARN Node Manager not ready! Exiting..."
#     echo -e "--------------------------------------------"
#     exit $rc
# fi

/wait-for-it.sh ${SP_HIVEMETASTORE}:9083 -t 360
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Hive Metastore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

/wait-for-it.sh ${SP_IMPALA_STATESTORE}:24000 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Impala StateStore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

/wait-for-it.sh ${SP_IMPALA_CATALOG}:25020 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Impala Catalog not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

supervisorctl start impala-server

/wait-for-it.sh localhost:21050 -t 120
/wait-for-it.sh localhost:25000 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi


echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Impala UIs:\n"
echo -e "Impala Daemon      http://localhost:25000"
echo -e "--------------------------------------------------------------------------------\n\n"


if [[ $SP_HDFS_NFS_GATEWAY -eq "yes" ]]; then

    echo -e "\n---------------------------------------"
    echo -e "     Starting HDFS to NFS gateway..."
    echo -e "---------------------------------------"

    supervisorctl start rpcbind

    supervisorctl start hdfs-nfs-gateway

fi
