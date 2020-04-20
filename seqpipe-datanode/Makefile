all: seqpipe-datanode.flag

seqpipe-datanode.flag:
	docker build . -t seqpipe/seqpipe-datanode:CDH6.3.2 && touch seqpipe-datanode.flag

publish: seqpipe-datanode.flag
	docker push seqpipe/seqpipe-datanode:CDH6.3.2

clean:
	rm -f seqpipe-datanode.flag
