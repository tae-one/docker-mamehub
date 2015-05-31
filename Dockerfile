FROM ubuntu:12.04
MAINTAINER Felix Maldonado <tae.one@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

# Install Oracle Java 7
RUN apt-get -y update
RUN apt-get -y install python-software-properties
RUN apt-get -y install openjdk-7-jre

# Install MAMEHub dependencies
RUN apt-get -y update
RUN apt-get -y install wget zip unzip libsdl1.2-dev libfontconfig1-dev libgconf2-dev libgtk2.0-dev libsdl-ttf2.0-dev yasm libqt4-dev aria2 libswt-*
RUN mkdir -p ~/.swt/lib/linux/x86_64/
RUN ln -s /usr/lib/jni/libswt-* ~/.swt/lib/linux/x86_64/

# Download and extract MAME Hub
RUN ["/bin/bash", "-c", "cd /opt && wget http://10ghost.net/MAMEHubDownloads/MAMEHub2_3.1.0.zip"]
RUN ["/bin/bash", "-c", "cd /opt && unzip *.zip"]

VOLUME ["/config","/data"]

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"

EXPOSE 6805 

CMD ["/bin/bash", "-c", "/opt/MAMEHub/MAMEHub.sh"]
