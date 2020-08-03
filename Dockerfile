FROM ubuntu:latest
MAINTAINER jshridha

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Configure user nobody to match unRAID's settings
 RUN \
 usermod -u 99 nobody && \
 usermod -g 100 nobody && \
 usermod -d /config nobody && \
 chown -R nobody:users /home

RUN apt-get update &&  apt-get -y install xvfb x11vnc xdotool wget supervisor cabextract websockify net-tools gnupg software-properties-common

ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

# Install wine
RUN \
 dpkg --add-architecture i386 && \
 wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
 apt-key add - && \
 sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ && \
 apt-get update && \
 apt-get -y install --allow-unauthenticated --install-recommends winehq-stable mono-complete wine-gecko
#Update One More Time
RUN apt-get update
RUN apt-get upgrade -y
#Wine Continues
RUN \
 cd /usr/bin/ && \
 wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
 chmod +x winetricks && \
 sh winetricks corefonts wininet

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD blueiris.sh /root/blueiris.sh
RUN chmod +x /root/blueiris.sh

RUN mv /root/prefix32 /root/prefix32_original && \
    mkdir /root/prefix32

WORKDIR /root/
ADD novnc /root/novnc/

# Expose Port
EXPOSE 8080

CMD ["/usr/bin/supervisord"]
