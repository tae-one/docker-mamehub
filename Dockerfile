FROM ubuntu:12.04
MAINTAINER Felix Maldonado <tae.one@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

EXPOSE 6805 

# Install packages
RUN apt-get -y update && apt-get -y install python-software-properties openjdk-7-jre wget zip unzip libsdl1.2-dev libfontconfig1-dev libgconf2-dev libgtk2.0-dev libsdl-ttf2.0-dev yasm libqt4-dev aria2 libswt-*

RUN mkdir -p ~/.swt/lib/linux/x86_64/
RUN ln -s /usr/lib/jni/libswt-* ~/.swt/lib/linux/x86_64/

# Download and extract MAME Hub
ADD http://10ghost.net/MAMEHubDownloads/MAMEHub2_3.1.0.zip /app/MAMEHub2_3.1.0.zip
RUN ["/bin/bash", "-c", "cd /app && unzip *.zip"]

ADD http://10ghost.net/MAMEHubDownloads/Tools/Updater3.jar /app/Updater.jar
RUN java -jar /app/Updater.jar

WORKDIR /app/MAMEHub/MAMEHubRepo/Binaries/dist
CMD ["/bin/bash", "-c", "java -Xmx1g -jar MAMEHubClient.jar"]
