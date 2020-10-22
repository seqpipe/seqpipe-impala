all: seqpipe-catalog.flag

seqpipe-catalog.flag:
	docker build . -t seqpipe/seqpipe-catalog:CDH6.3.2udf && touch seqpipe-catalog.flag

publish: seqpipe-catalog.flag
	docker push seqpipe/seqpipe-catalog:CDH6.3.2udf

clean:
	rm -f seqpipe-catalog.flag
