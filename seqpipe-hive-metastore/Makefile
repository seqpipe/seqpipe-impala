all: seqpipe-hive-metastore.flag

seqpipe-hive-metastore.flag:
	docker build . -t seqpipe/seqpipe-hive-metastore:CDH6.3.2udf && touch seqpipe-hive-metastore.flag

publish: seqpipe-hive-metastore.flag
	docker push seqpipe/seqpipe-hive-metastore:CDH6.3.2udf

clean:
	rm -f seqpipe-hive-metastore.flag
