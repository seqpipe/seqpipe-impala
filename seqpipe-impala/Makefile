all: seqpipe-impala.flag

seqpipe-impala.flag:
	docker build . -t seqpipe/seqpipe-impala:CDH6.3.2 && touch seqpipe-impala.flag

publish: seqpipe-impala.flag
	docker push seqpipe/seqpipe-impala:CDH6.3.2

clean:
	rm -f seqpipe-impala.flag
