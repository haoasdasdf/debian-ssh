FROM       debian:latest
MAINTAINER Jacky "https://github.com/haoasdasdf/debian-ssh"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

# My custom
WORKDIR /root/

RUN echo 'deb http://ftp.jp.debian.org/debian/ stretch main' > /etc/apt/sources.list
RUN echo 'deb-src http://ftp.jp.debian.org/debian/ stretch main' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://security.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list

RUN apt-get update && apt-get install  git nano supervisor curl wget cron screen -y 

CMD    ["/usr/sbin/sshd", "-D"]