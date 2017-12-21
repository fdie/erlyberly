#
# Oracle Java 8 Dockerfile
#
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#

# Pull base image.
#FROM dockerfile/ubuntu
FROM debian:stretch

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts

# Set environment variables.
#ENV HOME /root

# Define working directory.
#WORKDIR /root

# Install Java.
RUN apt-get install software-properties-common dirmngr && \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu yakkety main" && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
apt update -y && \
apt-get install -y oracle-java8-installer

#RUN   echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections &&   add-apt-repository -y ppa:webupd8team/java &&   apt-get update &&   apt-get install -y oracle-java8-installer &&   rm -rf /var/lib/apt/lists/* &&   rm -rf /var/cache/oracle-jdk8-installer


# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN cd /tmp && wget http://mirror.ibcp.fr/pub/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip && \
cd /opt && unzip /tmp/apache-maven-3.5.2-bin.zip

ENV MVN_HOME /opt/apache-maven-3.5.2

ENV PATH="${MVN_HOME}/bin:${JAVA_HOME}/bin:${PATH}"

# Define default command.
CMD ["/bin/bash"]
