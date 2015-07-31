FROM ubuntu:trusty
MAINTAINER Felix Maldonado <tae.one@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

VOLUME ["/roms"]

RUN apt-get update && \
    apt-get install -y unzip zip supervisor python-software-properties xvfb x11vnc openjdk-7-jre wget zip unzip libsdl1.2-dev libfontconfig1-dev libgconf2-dev libgtk2.0-dev libsdl-ttf2.0-dev yasm libqt4-dev aria2 libswt-* && \
    apt-get clean

ADD http://10ghost.net/MAMEHubDownloads/MAMEHub2_3.1.0.zip /MAMEHub2_3.1.0.zip
RUN ["/bin/bash", "-c", "unzip MAMEHub2_3.1.0.zip"]

RUN mkdir -p ~/.swt/lib/linux/x86_64/
RUN ln -s /usr/lib/jni/libswt-* ~/.swt/lib/linux/x86_64/

ADD ./start.sh /start.sh
RUN chmod u+x /start.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6805

CMD ["/usr/bin/supervisord"]
