set -e

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/hadoop/conf/core-site.xml

mkdir -p /data/dn/
chown hdfs:hadoop -R /data/dn

mkdir -p /data/lib/hadoop-hdfs/cache/hdfs/dfs/name
chown hdfs:hadoop -R /data/lib/hadoop-hdfs

/wait-for-it.sh ${SP_NAMENODE}:8020 -t 120

echo -e "\n---------------------------------------"
echo -e	"Starting DataNode..."
supervisorctl start hdfs-datanode

/wait-for-it.sh localhost:50075 -t 120
/wait-for-it.sh localhost:50010 -t 120
/wait-for-it.sh localhost:50020 -t 120

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - DataNode:                     http://localhost:50075"
echo -e "--------------------------------------------------------------------------------\n\n"
