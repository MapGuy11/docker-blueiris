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

RUN apt-get update &&  apt-get -y install xvfb x11vnc xdotool wget supervisor cabextract websockify net-tools gnupg software-properties-common fluxbox

ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

# Install wine
RUN \
 dpkg --add-architecture i386 && \
 wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
 apt-key add winehq.key && \
 add-apt-repository https://dl.winehq.org/wine-builds/ubuntu/ && \
 mkdir /opt/wine-stable/share/wine/mono && wget -O - https://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-bin-4.9.4.tar.gz |tar -xzv -C /opt/wine-stable/share/wine/mono && \
 mkdir /opt/wine-stable/share/wine/gecko && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi && \ 
 apt-get -y full-upgrade && apt-get clean && \
 apt-get -y install winehq-stable
RUN \
 cd /usr/bin/ && \
 wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
 chmod +x winetricks && \
 sh winetricks corefonts wininet

ADD https://raw.githubusercontent.com/MapGuy11/docker-blueiris/master/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD https://raw.githubusercontent.com/MapGuy11/docker-blueiris/master/blueiris.sh /root/blueiris.sh
RUN chmod +x /root/blueiris.sh

RUN mv /root/prefix32 /root/prefix32_original && \
    mkdir /root/prefix32

#Install noVNC
WORKDIR /root/
RUN wget -O zip.zip  https://github.com/novnc/noVNC/archive/v1.2.0.zip
RUN apt install unzip -y
RUN unzip zip.zip -d /root
RUN mv /root/noVNC-1.2.0 /root/novnc
RUN ln -s /root/novnc/vnc.html /root/novnc/index.html
# Expose Port
EXPOSE 8080

CMD ["/usr/bin/supervisord"]

