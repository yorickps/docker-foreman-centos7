#!/bin/bash

#Cleaning up Yum repo
yum clean all

# Installing Puppet Repo"
yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Installing Foreman repo"
yum -y install epel-release 
yum -y install https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm
sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g"/JAVA_ARGS="-Xms512m -Xmx512m"/g' /etc/sysconfig/puppetserver
printf "[agent]\n server = puppetmaster" >>  /etc/puppetlabs/puppet/puppet.conf
setenforce permissive
sed -i 's/=enforcing/=permissive/g' /etc/sysconfig/selinux
sed -i '/^PasswordAuthentication/PasswordAuthentication yes/g' /etc/ssh/sshd_config

systemctl start firewalld
firewall-cmd --zone=public --add-port=8140/tcp --permanent
firewall-cmd --zone=public --add-port=8443/tcp --permanent
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --reload

yum -y install foreman-installer

export FACTER_fqdn=foreman.ice.local
#export FACTER_fqdn=$(hostname)

#foreman-installer --foreman-admin-password foreman

# Cleaning yum repo
yum clean all
