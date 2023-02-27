---
toc: true
layout: post
description: Linux commands cheat sheet
categories: [linux]
title: Linux commands cheat sheet
---

# Linux commands cheat sheet

# SWAP management

Disable Swap memory

```
swapoff -a
```


# Networking

Get the ip 
```
ip addr show
```

Get Dhcp lease for interface ethx
```
dhclient -v ethx
```

Configure a network interface
Use netplan:
```
 cat /etc/netplan/01-netcfg.yaml
```
Output:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: no
      addresses: [192.168.56.103/24]
```
Commands to generate and apply the updates to the network config

```
netplan generate
netplan apply
```

## Firewall

## List all rules in IP tables
iptables -L

### iptables  commands



iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F


Uncomplicated firewall status / enable
https://help.ubuntu.com/community/UFW

```
ufw status
```

Example commands to allow / deny all traffic

```
ufw default allow incoming
ufw default deny incoming
```

Add port 6443 tcp

```
ufw allow 6443/tcp
```

Allow port ranges:

```
ufw allow 1000:2000/tcp
```

# Hostname
Get the current data for the current host:

```
hostnamectl status
```

get the hostname
```
hostname
```

set hostname:
```
hostnamectl set-hostname <yourhostname here>
```

# System logging

Kernel log:
```
dmesg | tail
```


## log file locations

### Authorization log
/var/log/auth.log

### Daemon Log
/var/log/daemon.log

### Debug log
/var/log/debug

### Kernel log
/var/log/kern.log

### System log
/var/log/syslog

systemctl status appname


### Application logs 

### Apache
/var/log/apache2/ 

### X11
/var/log/Xorg.0.log

### login failures
/var/log/faillog
read with faillog command

### Last logins log
/var/log/lastlog 
read with lastlog command

### Login records log
/var/log/wtmp read with who command


## Containers

## Containerd
https://iximiuz.com/en/posts/containerd-command-line-clients/

### list all namespaces
```
sudo ctr namespaces list
```

### list all containers running in kubernetes
```
sudo ctr -n k8s.io containers list
```

### list all tasks running
```
sudo ctr -n k8s.io task list
```

## Check the content of an interface
```
 sudo tcpdump -i tunl0
```
## Restart all daemons
```
sudo systemctl daemon-reload
```

## check what a command does 
```
strace command

strace kubectl get endpoints
```

## Crictl
config file in crictl /etc/crictl.yaml
config options: https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md

