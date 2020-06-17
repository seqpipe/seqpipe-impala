SUBDIRS := seqpipe-cdh-base seqpipe-namenode seqpipe-zookeeper seqpipe-hive-metastore \
	seqpipe-impala-base seqpipe-catalog seqpipe-statestore \
	seqpipe-impala-worker seqpipe-hdfs-nfs-gateway

TOPTARGETS := all clean publish

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)