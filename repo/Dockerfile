FROM ubuntu:12.04


RUN apt-get update -y -qq
RUN apt-get install -y ruby1.9.1-dev \
    build-essential \
    binutils
RUN gem install deb-s3 --no-rdoc --no-ri

ADD build_repo.sh /build_repo.sh

CMD /build_repo.sh
