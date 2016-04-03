#!/bin/bash

#Cleaning up Yum repo
sudo yum clean all

# Installing Puppet Repo"
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

# Installing Foreman repo"
sudo yum -y install epel-release http://yum.theforeman.org/releases/1.9/el7/x86_64/foreman-release.rpm

sudo yum -y install foreman-installer

export FACTER_fqdn=$(hostname)

sudo foreman-installer --foreman-admin-password foreman

# Cleaning yum repo
yum clean all
