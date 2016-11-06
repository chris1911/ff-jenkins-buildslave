FROM debian:jessie

MAINTAINER chris1911@users.noreply.github.com

ENV	DEBIAN_FRONTEND noninteractive

RUN	echo >> /etc/apt/apt.conf.d/00aptitude 'APT::Install-Recommends "0";' && \
	echo >> /etc/apt/apt.conf.d/00aptitude 'APT::Install-Suggests "0";' && \
	apt-get -y update && \
	apt-get -y install bsdmainutils build-essential ca-certificates cmake file flex \
			   gawk gettext git less liblzma-dev liblzma5 libncurses5-dev libssl-dev \
			   openjdk-8-jdk-headless openssh-server p7zip-full pkg-config python \
			   subversion sudo unzip vim wget xauth zlib1g-dev

RUN	mkdir -p /var/run/sshd && \
	locale-gen en_US.UTF-8 && \
	echo >> /etc/default/locale "LANG=en_US.UTF-8"

RUN	useradd -m jenkinsslave -s /bin/bash

EXPOSE  22
CMD     /usr/sbin/sshd -D

# allow remote access via ssh-key, only. All other users do not have a pwd set
# add authorized_keys from host via volume mapping and expose the port
