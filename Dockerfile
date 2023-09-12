FROM ubuntu:focal
MAINTAINER Kry9toN <kry9ton@kryptonproject.my.id>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends dpkg-dev nginx inotify-tools supervisor python3-gevent python3 python3-pip \
    && pip3 install termux-apt-repo \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD supervisord.conf /etc/supervisor/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /
ADD scan.py /

ENV DISTS termux
ENV ARCHS aarch64,arm
EXPOSE 80
VOLUME /data
ENTRYPOINT ["/startup.sh"]
