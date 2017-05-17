#!/bin/bash

#Cleaning up Yum repo
yum clean all

# Installing Puppet Repo"
yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Installing Foreman repo"
yum -y install epel-release 
yum -y install https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm

yum -y install foreman-installer

export FACTER_fqdn=foreman.ice.local
#export FACTER_fqdn=$(hostname)

foreman-installer --foreman-admin-password foreman

# Cleaning yum repo
yum clean all
