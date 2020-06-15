all: seqpipe-namenode.flag

seqpipe-namenode.flag:
	docker build . -t seqpipe/seqpipe-namenode:CDH6.3.2 && touch seqpipe-namenode.flag

publish: seqpipe-namenode.flag
	docker push seqpipe/seqpipe-namenode:CDH6.3.2

clean:
	rm -f seqpipe-namenode.flag
