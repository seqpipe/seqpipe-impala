set -e

sed -i \
    "s/ZOOKEEPER/${ZOOKEEPER}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/NAMENODE/${NAMENODE}/g" /etc/impala/conf/core-site.xml
sed -i \
    "s/HIVEMETASTORE/${HIVEMETASTORE}/g" /etc/impala/conf/hive-site.xml

/wait-for-it.sh ${HIVEMETASTORE}:9083 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Hive Metastore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

supervisorctl start impala-state-store
/wait-for-it.sh localhost:25010 -t 120
/wait-for-it.sh localhost:23000 -t 120
/wait-for-it.sh localhost:23020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     Impala statestore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Impala UIs:\n"
echo -e "Impala State Store      http://${IMPALA_STATESTORE}:25010"
echo -e "--------------------------------------------------------------------------------\n\n"
