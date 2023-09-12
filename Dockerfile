FROM ubuntu:focal
MAINTAINER Kry9toN <kry9ton@kryptonproject.my.id>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends dpkg-dev nginx supervisor python3 python3-pip gnupg \
    && pip3 install watchdog \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN gpg --batch --passphrase '' --quick-gen-key kry9ton default default

ADD supervisord.conf /etc/supervisor/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD termux-apt-repo.py /
RUN chmod +x /termux-apt-repo.py
ADD startup.sh /
ADD observer.py /
ADD scan.py /

RUN mkdir -p /data/web/
RUN mkdir -p /data/deb/

EXPOSE 80
VOLUME /data
ENTRYPOINT ["/startup.sh"]
