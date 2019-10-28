set -e

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/SP_HIVEMETASTORE/${SP_HIVEMETASTORE}/g" /etc/hadoop/conf/hive-site.xml

sed -i \
    "s/SP_ZOOKEEPER/${SP_ZOOKEEPER}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/SP_NAMENODE/${SP_NAMENODE}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/SP_HIVEMETASTORE/${SP_HIVEMETASTORE}/g" /etc/impala/conf/hive-site.xml


sed -i \
    "s/SP_IMPALA_STATESTORE/${SP_IMPALA_STATESTORE}/g" /etc/default/impala
sed -i \
    "s/SP_IMPALA_CATALOG/${SP_IMPALA_CATALOG}/g" /etc/default/impala

sed -i \
    "s/SP_RESOURCEMANAGER/0.0.0.0/g" /etc/hadoop/conf/yarn-site.xml


mkdir -p /data/dn/
chown hdfs:hadoop -R /data/dn

mkdir -p /data/nn
chown hdfs:hadoop -R /data/nn

echo -e "\n---------------------------------------"

if [[ ! -e /data/nn/current ]]; then
    	echo -e	"Initiating HDFS NameNode..."
	/etc/init.d/hadoop-hdfs-namenode init
	rc=$?
    	if [ $rc -ne 0 ]; then
	    	echo -e	"HDFS initiation ERROR!"
    	else
        	echo -e	"HDFS successfully formatted!"
    	fi
fi

/wait-for-it.sh ${SP_ZOOKEEPER}:2181 -t 120

echo -e	"Starting NameNode..."
supervisorctl start hdfs-namenode

/wait-for-it.sh localhost:8020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
        echo -e "\n\n--------------------------------------------------------------------------------"
        echo -e "ERROR: HDFS namenode failed to start"
        echo -e "--------------------------------------------------------------------------------\n\n"
        exit 1
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - NameNode:                     http://${SP_NAMENODE}:9870"
echo -e "--------------------------------------------------------------------------------\n\n"


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


/wait-for-it.sh ${SP_HIVEMETASTORE}:9083 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Hive Metastore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi


supervisorctl start impala-state-store
/wait-for-it.sh localhost:25010 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala statestore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

/wait-for-it.sh localhost:24000 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala statestore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start impala-catalog

/wait-for-it.sh localhost:25020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala catalog not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Impala UIs:\n"
echo -e "Impala State Store      http://${SP_IMPALA_STATESTORE}:25020"
echo -e "--------------------------------------------------------------------------------\n\n"

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Impala UIs:\n"
echo -e "Impala Catalog      http://${SP_IMPALA_CATALOG}:25020"
echo -e "--------------------------------------------------------------------------------\n\n"
