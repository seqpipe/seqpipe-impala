all: seqpipe-impala-worker.flag

seqpipe-impala-worker.flag:
	docker build . -t seqpipe/seqpipe-impala-worker:CDH6.3.2 && touch seqpipe-impala-worker.flag

publish: seqpipe-impala-worker.flag
	docker push seqpipe/seqpipe-impala-worker:CDH6.3.2

clean:
	rm -f seqpipe-impala-worker.flag
