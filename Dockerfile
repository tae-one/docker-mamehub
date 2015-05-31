####  THIS DOCKERFILE HAS NOT BEEN TESTED ####

FROM ubuntu:12.04
MAINTAINER Felix Maldonado <tae.one@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

# update packages
RUN apt-get -y update
RUN apt-get -y upgrade

# Install Oracle Java 7
RUN apt-get -y install python-software-properties
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN echo "oracle-java7-installer  shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
RUN apt-get -y install oracle-java7-installer

# Install dependencies for MAME Hub
RUN apt-get install apt-get install libfontconfig1-dev libgconf2-dev libgtk2.0-dev libsdl2-ttf-dev yasm libqt4-dev aria2 libSDL2-dev 

# Download and extract MAME Hub
RUN cd /opt && wget http://10ghost.net/MAMEHubDownloads/MAMEHub2_3.1.0.zip
RUN cd /opt && unzip *.zip

VOLUME ["/config","/data"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"

EXPOSE 6805 

CMD ["/start.sh"]


