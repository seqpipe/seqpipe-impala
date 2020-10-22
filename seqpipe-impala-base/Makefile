all: seqpipe-impala-base.flag

seqpipe-impala-base.flag:
	docker build . -t seqpipe/seqpipe-impala-base:CDH6.3.2udf && touch seqpipe-impala-base.flag

publish: seqpipe-impala-base.flag
	docker push seqpipe/seqpipe-impala-base:CDH6.3.2udf

clean:
	rm -f seqpipe-impala-base.flag
