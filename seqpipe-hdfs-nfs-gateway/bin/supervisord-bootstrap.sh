set -e

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_REPLICATION/${SP_REPLICATION}/g" /etc/hadoop/conf/hdfs-site.xml


/wait-for-it.sh ${SP_NAMENODE}:8020 -t 120

# echo -e "\n---------------------------------------"
# echo -e	"Starting DataNode..."
# supervisorctl start hdfs-datanode

# /wait-for-it.sh localhost:9864 -t 120
