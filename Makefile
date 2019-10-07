all: 
	cd seqpipe-zookeeper && docker build . -t seqpipe/seqpipe-zookeeper:latest && cd .. && \
	cd seqpipe-namenode && docker build . -t seqpipe/seqpipe-namenode:latest && cd ..
	
