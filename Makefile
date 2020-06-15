SUBDIRS := seqpipe-cdh-base seqpipe-namenode seqpipe-zookeeper seqpipe-hive-metastore \
	seqpipe-hdfs-nfs-gateway seqpipe-impala-base seqpipe-catalog seqpipe-statestore \
	seqpipe-impala-worker

TOPTARGETS := all clean publish

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)