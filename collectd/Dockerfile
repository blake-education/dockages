FROM ubuntu:12.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && apt-get update && apt-get install -y python-software-properties && apt-get clean

RUN apt-get install -y protobuf-c-compiler libprotobuf-c0-dev \
                       curl build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev \
                       ruby1.9.1-dev && \
    gem install fpm --no-rdoc --no-ri

ADD collectd.upstart /build/collectd.upstart
ADD http://collectd.org/files/collectd-5.4.1.tar.bz2 /build

RUN cd /build/collectd-5.4.1 && ./configure --enable-write_riemann && make && make install DESTDIR=/tmp/collectd

RUN  fpm -f -s dir -t deb -n collectd -v 5.4.1-blake1 -C /tmp/collectd \
    -p /collectd-VERSION_ARCH.deb \
    -d "libprotobuf-c0 (>= 0.14)" \
    --deb-upstart /build/collectd.upstart \
    opt
