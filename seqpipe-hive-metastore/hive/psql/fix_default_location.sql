
update "DBS" set "DB_LOCATION_URI" = 'hdfs://${NAMENODE}:8020/user/hive/warehouse' where "NAME"='default';
