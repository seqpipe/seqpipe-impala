all: seqpipe-cdh-base.flag

seqpipe-cdh-base.flag:
	docker build . -t seqpipe/seqpipe-cdh-base:CDH6.3.2 && touch seqpipe-cdh-base.flag

publish: seqpipe-cdh-base.flag
	docker push seqpipe/seqpipe-cdh-base:CDH6.3.2

clean:
	rm -f seqpipe-cdh-base.flag
