all: seqpipe-hdfs-nfs-gateway.flag

seqpipe-hdfs-nfs-gateway.flag:
	docker build . -t seqpipe/seqpipe-hdfs-nfs-gateway:CDH6.3.2udf && touch seqpipe-hdfs-nfs-gateway.flag

publish: seqpipe-hdfs-nfs-gateway.flag
	docker push seqpipe/seqpipe-hdfs-nfs-gateway:CDH6.3.2udf

clean:
	rm -f seqpipe-hdfs-nfs-gateway.flag
