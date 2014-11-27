FROM ubuntu:12.04


RUN apt-get update -y && \
	apt-get install -y ruby1.9.1 python-software-properties python-pip binutils && \
    gem install prm --no-rdoc --no-ri && \
    pip install awscli

ADD debs /debs
ADD build.sh /build.sh

CMD /build.sh
