#!/bin/bash

rm -f /tmp/zookeeper 2> /dev/null

supervisorctl start zookeeper


/wait-for-it.sh localhost:2181 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      Zookeeper not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "Zookeeper running on port 2181"
echo -e "--------------------------------------------------------------------------------\n\n"
