FROM centos:centos7
MAINTAINER Loris Strozzini <lstrozzini@gmail.com>
ADD ./install.sh /opt/install.sh
ADD ./start.sh /opt/start.sh
RUN cd /opt && bash -x install.sh
EXPOSE 3000 443
ENTRYPOINT cd /opt && bash start.sh
