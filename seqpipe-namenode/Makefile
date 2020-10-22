all: seqpipe-namenode.flag

seqpipe-namenode.flag:
	docker build . -t seqpipe/seqpipe-namenode:CDH6.3.2udf && touch seqpipe-namenode.flag

publish: seqpipe-namenode.flag
	docker push seqpipe/seqpipe-namenode:CDH6.3.2udf

clean:
	rm -f seqpipe-namenode.flag
