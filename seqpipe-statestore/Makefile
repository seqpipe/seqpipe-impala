all: seqpipe-statestore.flag

seqpipe-statestore.flag:
	docker build . -t seqpipe/seqpipe-statestore:CDH6.3.2 && touch seqpipe-statestore.flag

publish: seqpipe-statestore.flag
	docker push seqpipe/seqpipe-statestore:CDH6.3.2

clean:
	rm -f seqpipe-statestore.flag
