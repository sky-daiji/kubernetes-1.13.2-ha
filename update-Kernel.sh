#!/bin/bash
yum install -y wget vim net-tools
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum install wget git  jq psmisc -y
yum install https://mirrors.aliyun.com/saltstack/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
sed -i "s/repo.saltstack.com/mirrors.aliyun.com\/saltstack/g" /etc/yum.repos.d/salt-latest.repo
yum update -y
export Kernel_Vsersion=4.18.9-1
wget http://software.mofangge.cc/linux/Kernel/kernel-ml-4.18.9-1.el7.elrepo.x86_64.rpm
yum localinstall -y kernel-ml*
find /lib/modules -name '*nf_conntrack_ipv4*' -type f
grub2-set-default  0 && grub2-mkconfig -o /etc/grub2.cfg
grubby --default-kernel
reboot
