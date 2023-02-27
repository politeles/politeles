---
toc: true
layout: post
description: Kubernetes cheat sheet 2
categories: [kubernetes]
title: Kubernetes cheat sheet 2
---

# Kubernetes cheat sheet

## check all k8s actions
```
kubectl get events
```
## restart kubelet
sudo systemctl restart kubelet

## uncordon a node:
politeles@cp:~$ kubectl get node
NAME      STATUS                     ROLES           AGE   VERSION
cp        Ready,SchedulingDisabled   control-plane   33h   v1.25.1
worker1   Ready                      <none>          32h   v1.24.1
politeles@cp:~$ kubectl uncordon cp
node/cp uncordoned
politeles@cp:~$ kubectl get node
NAME      STATUS   ROLES           AGE   VERSION
cp        Ready    control-plane   33h   v1.25.1
worker1   Ready    <none>          32h   v1.24.1




## replace a deployment
 kubectl replace -f first.yaml
 
## In which node is executing a pod
```
politeles@cp:~$ kubectl describe pod nginx-6c8b449b8f-87d4t | grep Node:
Node:         worker1/10.0.2.5
```


## deploy with a load balancer
 kubectl expose deployment nginx --type=LoadBalancer

# ETCD Maintenance
Log into container

```
kubectl -n kube-system exec -it etcd-cp -- sh
```

Get the certificates:
```
cd /etc/kubernetes/pki/etcd
sh-5.1# echo *
ca.crt ca.key healthcheck-client.crt healthcheck-client.key peer.crt peer.key server.crt server.key
```

## backup data dir
```
politeles@cp:~$ sudo grep data-dir /etc/kubernetes/manifests/etcd.yaml
[sudo] password for politeles:
    - --data-dir=/var/lib/etcd
```

Health check:

```
 kubectl -n kube-system exec -it etcd-cp -- sh \
> -c "ETCDCTL_API=3 \
> ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
> ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
> ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
> etcdctl endpoint health"
```

 kubectl -n kube-system exec -it etcd-cp -- sh \
> -c "ETCDCTL_API=3 \
> ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
> ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
> ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
> etcdctl --endpoints=https://127.0.0.1:2379 member list"

Save snapshot of etcd:
```
politeles@cp:~$ kubectl -n kube-system exec -it etcd-cp -- sh -c "ETCDCTL_API=3 \
ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
etcdctl --endpoints=https://127.0.0.1:2379 snapshot save /var/lib/etcd/snapshot.db"
```

# Check system logs
kubectl get events

# Plugins for kubernetes:
https://github.com/kubernetes-sigs/krew/


# Troubleshooting

https://kubernetes.io/docs/tasks/debug/debug-application/

https://kubernetes.io/docs/tasks/debug/debug-cluster/

https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/

https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/

https://github.com/kubernetes/kubernetes/issues

https://kubernetes.slack.com/

## Log file locations

```
journalctl -u kubelet | less
```

### Control plane
sudo find / -name "*apiserver*log"

/var/log/kube-apiserver.log
/var/log/kube-scheduler.log
/var/log/kube-controller-manager.log

/var/log/containers

/var/log/pods

### Worker nodes

/var/log/kubelet.log
/var/log/kube-proxy.log
