set -e

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


/wait-for-it.sh ${SP_HIVEMETASTORE}:9083 -t 240

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

/wait-for-it.sh impala:21050 -t 120
/wait-for-it.sh impala:25000 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi


echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Impala UIs:\n"
echo -e "Impala Catalog      http://localhost:25000"
echo -e "--------------------------------------------------------------------------------\n\n"
