FOM ubuntu:12.04
MAINTAINER Felix Maldonado <tae.one@gmail.com>

# Install Oracle Java 7
RUN apt-get -y update
RUN apt-get -y install python-software-properties
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN echo "oracle-java7-installer  shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
RUN apt-get -y install oracle-java7-installer zip unzip
RUN locate .swt/lib/linux/x86_64 | xargs ln -s /usr/lib/jni/* 

# Download and extract MAME Hub
RUN cd /opt && wget http://10ghost.net/MAMEHubDownloads/MAMEHub2_3.1.0.zip
RUN cd /opt && unzip *.zip

RUN apt-get -y install libsdl1.2-dev libfontconfig1-dev libgconf2-dev libgtk2.0-dev libsdl-ttf2.0-dev yasm libqt4-dev aria2
RUN wget -N http://10ghost.net/MAMEHubDownloads/Tools/Updater3.jar -P /opt/MAMEHub/Tools

VOLUME ["/config","/data"]

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"

EXPOSE 6805 

CMD ["/opt/MAMEHub/MAMEHub.sh"]
