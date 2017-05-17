FROM centos:centos7
MAINTAINER Loris Strozzini <lstrozzini@gmail.com>
ADD ./install.sh /opt/install.sh
ADD ./start.sh /opt/start.sh


#Cleaning up Yum repo
RUN yum clean all

# Installing Puppet Repo"
RUN yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && yum -y install puppet-agent

# Installing Foreman repo"
RUN yum -y install epel-release 
RUN yum -y install https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm
RUN puppet apply -e 'host { $::hostname: ensure => absent } -> host { "${::hostname}.docker.local": ip => $::ipaddress, host_aliases => [$::hostname] }' 

COPY foreman-installer-answers.yaml /etc/foreman/
RUN foreman-installer --foreman-admin-password changeme

#export FACTER_fqdn=foreman.ice.local
#export FACTER_fqdn=$(hostname)


# Cleaning yum repo
yum clean all

#RUN cd /opt && bash -x install.sh
EXPOSE 3000 443
ENTRYPOINT cd /opt && bash start.sh
