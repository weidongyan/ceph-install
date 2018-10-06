#!/bin/bash
echo -e "\nAdding ceph user"
useradd ceph
echo redhat | passwd ceph --stdin

echo -e "\n Configuring passwordless for student and ceph users"
echo 'Defaults:root !requiretty' >> /etc/sudoers
echo 'Defaults:ceph !requiretty' >> /etc/sudoers
echo 'Defaults:student !requiretty' >> /etc/sudoers
echo "ceph ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "student ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo -e "\nApply updates."
yum -y update

echo -e "\nDisabling Firewall."
systemctl stop firewalld
systemctl disable firewalld

echo -e "\nDisabling SELinux."
setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config

