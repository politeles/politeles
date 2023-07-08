---
aliases:
- /2022/12/02/Installing-kubernetes-in-Virtual-Box
categories:
- kubernetes
date: '2022-12-02'
description: Install Kubernetes in Virtual Box
layout: post
title: Install Kubernetes in Virtual Box
toc: true

---

# Install Kubernetes in Virtual Box

First we install ubuntu server on virtutal box

## Guest additions intallation
https://cambiatealinux.com/instalar-las-guest-additions-virtualbox-ubuntu-server


sudo apt install gcc make perl 


## Prepare networking
 - NAT address to the outside world
 - Host only address with dhcp


## Renew ip address from host only network

sudo dhclient -v enp0s8

## permanent option for host only

https://fabiofernandesx.medium.com/preparing-virtual-box-vms-to-run-kubernetes-a31c7c851566

 /etc/netplan

sudo -i 
vim /etc/netplan/01-netcfg.yaml

create the following yaml file

network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: no
      addresses: [192.168.56.101/24]

	 
netplan generate
sudo netplan apply



## Configure access to ssh server
https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-20-04/

```
sudo systemctl status ssh
```

enable firewall

```
sudo ufw allow ssh
```
ufw default allow incoming

### allow connection to k8s ports
sudo ufw allow 179/tcp
sudo ufw allow 4789/tcp
sudo ufw allow 5473/tcp
sudo ufw allow 443/tcp
sudo ufw allow 6443/tcp
sudo ufw allow 2379/tcp
sudo ufw allow 4149/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10255/tcp
sudo ufw allow 10256/tcp
sudo ufw allow 9099/tcp


## Change the hostname on the cloned VM

hostnamectl set-hostname <yourhostname here>

hostnamectl status 


## upgrade system
 sudo apt-get update
 sudo apt-get upgrade -y
 
## install vim
sudo apt-get install vim

## run sudo commands without password
sudo -i

# Kubernetes pre steps

## Packages:
```
sudo apt install curl apt-transport-https vim git wget gnupg2 software-properties-common apt-transport-https ca-certificates uidmap -y
```

## Disable swap
```
swapoff -a
```

## test modules
```
 modprobe overlay
 modprobe br_netfilter
```

## update kernel networking
```
cat << EOF | tee /etc/sysctl.d/kubernetes.conf
> net.bridge.bridge-nf-call-ip6tables = 1
> net.bridge.bridge-nf-call-iptables = 1
> net.ipv4.ip_forward = 1
> EOF
```
output:
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1

ensure to apply changes:

```
sysctl --system
```

## install software
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```
apt install containerd -y
```

 vim /etc/apt/sources.list.d/kubernetes.list
 add line:
deb http://apt.kubernetes.io/ kubernetes-xenial main

update key
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```

```
 apt-get update
```

## Kubernetes installation (here for the workernode)
```
apt-get install -y kubeadm=1.24.1-00 kubelet=1.24.1-00 kubectl=1.24.1-00
```

```
apt-mark hold kubeadm kubelet kubectl
```
kubeadm set on hold.
kubelet set on hold.
kubectl set on hold.



## network installation CALICO
```
wget https://docs.projectcalico.org/manifests/calico.yaml
```

```
ip addr show
```

10.0.2.15

create an alias in the /etc/hosts
10.0.2.15 k8scp

kubeadm config file (kubeadm-config.yaml)
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: 1.24.1
controlPlaneEndpoint: "k8scp:6443"
networking:
  podSubnet: 192.168.0.0/16
  
## initialize the control plane
```
kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-ini.out
```

exit
and run as regular user:
```
 mkdir -p $HOME/.kube
 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
## network configuration

copy the calico file into the current user.
```
sudo cp /root/calico.yaml .
```

apply the config:

```
 kubectl apply -f calico.yaml
```

## enable bash autocompletion
sudo apt-get install bash-completion -y

 source < (kubectl completion bash)
 echo "source <(kubectl completion bash)" >> $HOME/.bashrc
 
 
 ## view config
 sudo kubeadm config print init-defaults
 
 apiVersion: kubeadm.k8s.io/v1beta3
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: abcdef.0123456789abcdef
  ttl: 24h0m0s
  usages:
  - signing
  - authentication
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 1.2.3.4
  bindPort: 6443
nodeRegistration:
  criSocket: unix:///var/run/containerd/containerd.sock
  imagePullPolicy: IfNotPresent
  name: node
  taints: null
---
apiServer:
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta3
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes


# Configure worker node

## network config
 cat /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: no
      addresses: [192.168.56.103/24]

netplan generate
netplan apply

update hostname file with ens4 ip
ip addr show enp0s3 | grep inet
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s3
    inet6 fe80::a00:27ff:fe31:54bd/64 scope link

## on the control plane
 - get the token
 politeles@cp:~$ sudo kubeadm token create
qsm8ss.g8vf8w8qbro4z1vo
politeles@cp:~$ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
dce22f3d49e94e10e282e64024b9b5fddaa6ed78a635a8a744e4c55446e3a328

## on the worker node
update /etc/hosts with the hostname of the control plane

```
root@worker1:~# cat /etc/hosts
10.0.2.15 k8scp
```

Join the cluster


## untaint the control plane (just for non-prod)

```
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```
node/cp untainted
error: taint "node-role.kubernetes.io/control-plane" not found

## update containerd config

```
 sudo crictl config --set runtime-endpoint=unix:///run/containerd/containterd.sock --set image-endpoint=unix:///run/containerd/containerd.sock
```

