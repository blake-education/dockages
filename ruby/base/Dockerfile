FROM ubuntu:12.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
      apt-get update -y -qq && \
      apt-get install -y \
        python-software-properties \
        curl \
        build-essential \
        zlib1g-dev \
        libyaml-dev \
        libssl-dev \
        libgdbm-dev \
        libreadline-dev \
        libncurses5-dev \
        libffi-dev && \
      apt-get clean

ADD https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz /build/
ADD https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz /build/

RUN tar xvf /build/v0.4.3.tar.gz  -C /build

RUN tar xvf /build/v0.3.8.tar.gz -C /build

RUN cd /build/ruby-install-0.4.3 && \
	make install

RUN cd /build/chruby-0.3.8 && \
  	make install

ADD . /build
ADD build.env /build.env
