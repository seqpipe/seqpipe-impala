#!/bin/bash

set -e

sed -i \
    "s/ZOOKEEPER/${ZOOKEEPER}/g" /etc/hadoop/conf/core-site.xml
sed -i \
    "s/NAMENODE/${NAMENODE}/g" /etc/hadoop/conf/core-site.xml


supervisorctl start postgresql

/wait-for-it.sh localhost:5432 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      PostgreSQL not ready! Exiting..."
    echo -e "--------------------------------------------"
	exit $rc
fi

psql -h localhost -U postgres -c "CREATE DATABASE metastore;"

export COUNT=0

while :
do
    export COUNT=COUNT+1
    sleep 2

    export RESULT=$(psql -h localhost -U postgres -c "CREATE DATABASE metastore;" 2>&1)

    if [[ ($RESULT =~ "already exists") || ($RESULT =~ "CREATE DATABASE") ]]; then
            echo "DONE: database 'metastore' exists"
            break
    else
            echo "ERROR: database 'metastore' not created"
            export DONE=0
    fi

    if [[ $COUNT > 10 ]];
    then
            echo -e "\n\n--------------------------------------------------------------------------------"
            echo -e "ERROR: Can't init Hive Metastore"
            echo -e "--------------------------------------------------------------------------------\n\n"
            exit 1
    fi
done

$HIVE_HOME/bin/schematool -dbType postgres -initSchema

mkdir -p /opt/hive/hcatalog/var/log

/wait-for-it.sh ${NAMENODE}:8020 -t 240

supervisorctl start hive_metastore

/wait-for-it.sh localhost:9083 -t 240

psql -h localhost -U postgres -d metastore -a -f /fix_default_location.sql

supervisorctl restart hive_metastore

/wait-for-it.sh localhost:9083 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Hive Metastore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit 1
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "Hive Metastore running on localhost:9083"
echo -e "--------------------------------------------------------------------------------\n\n"
