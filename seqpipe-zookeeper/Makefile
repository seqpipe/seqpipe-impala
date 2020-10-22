all: seqpipe-zookeeper.flag

seqpipe-zookeeper.flag:
	docker build . -t seqpipe/seqpipe-zookeeper:CDH6.3.2udf && touch seqpipe-zookeeper.flag

publish: seqpipe-zookeeper.flag
	docker push seqpipe/seqpipe-zookeeper:CDH6.3.2udf

clean:
	rm -f seqpipe-zookeeper.flag
