---
toc: true
layout: post
description: Kubernetes cheat sheet
categories: [kubernetes]
title: Kubernetes cheat sheet
---

# Kubernetes cheat sheet

## Get nodes
kubectl get node
kubectl get no

With more outuput:
kubectl get nodes -o wide
kubectl get no -o yaml

With a JSON Query
kubectl get nodes -o json | jq ".items[] | {name:.metadata.name} + .status.capacity"


## Exploring types and definitions

kubectl explain node
kubectl explain node.spec

kubectl explain node --recursive

## Viewing details
kubectl describe node


## List of running pods

kubectl get pods

## Namespaces
kubectl get namespaces

To get all namespaces

kubectl get pods --all-namespaces
kubectl get pods -A

Scoping another namespaces

kubectl get pods -n kube-system

### Creation / deletion of namespaces
kubectl create -n=X
kubectl delete -n=X
To add / remove and update labels across multiple namespaces:
kubectl label 


## Kube-public

To get the cluster info:
kubectl -n kube-public get configmaps

kubectl -n kube-public get configmap cluster-info -o yaml

## Services
A service is an endpoint

kubectl get services
kubectl get svc

Example output:
PS C:\Users\polit\sources\container.training> kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   15h

We can connect to the API using the CLUSTER-IP value.


## ClusterIP services
Connections to the CLUSTER-IP can be done only from within the cluster.

## DNS integration
Each service gets a DNS record
The kubernetes DNS resolver is available from within the pods.(and sometimes from nodes depending on config).

## Starting a pod
kubectl run

kubectl run pingpong --image alpine ping 127.0.0.1

## viewing logs
unless specified it will show the logs of the first container only

kubectl logs pingpong

kubectl logs pingpong --tail 1 -follow

-f/--follow to stream logs in real time
--tail to indicate how many lines you want to see (from the end)
--since to get logs only after a given timestamp

## Creating a deployment

kubectl create deployment pingpong --image=alpine -- ping 127.0.0.1
The -- is to separate the options of kubernetes to the parameters of the container.

## what has been created?
kubectl get all

It doesn't show everything just the usual suspects.


# Pod 
- A Pod is not a process; it's an environment for containers
 - it cannot be "restarted"
 - it cannot "crash"

- The containers in a Pod can crash
- They may or may not get restarted (depending on Pod's restart policy)
- If all containers exit successfully, the Pod ends in "Succeeded" phase
- If some containers fail and don't get restarted, the Pod ends in "Failed" phase

# Replica set
- Set of identical pods.
- Defined by a pod template + number of desired replicas.
- When scale up / down:
 - we update the manifest of the replica set.
 - as a consequence, the replica set controller creates / deletes pods.

# Deployment
Deployments roll out different Pods (different image, command, environment vars...)
- When we update a deployment with a new Pod definition:
 - a new replica set is created with the new pod definition.
 - that new Replica is scaled up.
 - the old replica set is scaled down.
- This is a rolling update, minimizing application downtime.
- When we scale up/down a Deployment, it scales up / down its replica set.

## Scaling the deployment:
kubectl scale deployment pingpong --replicas 3

to check we have multiple pods:
kubectl get pods

### Scaling a replica set
What if we scale the replica set?
- The deployment will notice and will scale back to the initial level.
- The replica set makes sure to have the right number of pods.
- The deployment makes sure the Replica set has the right size.

## Checking deployment logs
kubectl logs deploy/pingpong --tail 2

# Batch Jobs
Pods don't get restarted if something goes wrong. Jobs are great for long background jobs.
CronJobs are for scheduled jobs.

## Creating a job

kubectl create job flipcoin --image=alpine -- sh -c 'exit $(($RANDOM%2))'

check the status with name selector:
kubectl get pods --selector=job-name=flipcoin

- We can specify a number of "completions" (default=1)

- We can specify the "parallelism" (default=1)

## Scheduling periodic background work CronJob
It requires a schedule
 - minute [0,59]
 - hour [0,23]
 - day of the month [1,31]
 - month of the year[1,12]
 - day of the week [0,6] 0= Sunday.
for example:
*/3 * * * * means every three minutes.

### Cronjob creation
kubectl create cronjob every3mins --schedule="*/3 * * * *" \
        --image=alpine -- sleep 10
		
To check the job:
kubectl get cronjobs

The job will create a pod, the job will make sure the pod completes (re-creating another one if it fails).

Setting a time limit:
This is done with the field spec.activeDeadlineSeconds.
When the job is older than the limit, all its pods are terminated.
**Note that there can be also a deadline for the pods**
They can be set independently with different effect:
- the deadline of the job will stop the entire job.
- the deadline of the pod will stop only a pod.

# Labels and annotations
Set a label on the clock Deployment:
kubectl label deployment clock color=blue

kubectl describe deployment clock

List all the labels that we have on pods:

kubectl get pods --show-labels

List the value of label app on these pods:

kubectl get pods -L app

**If a selector has multiple labels, it means "match at least these labels"**

Example: --selector=app=frontend,release=prod

*We can use negative selectors* 
--selector=app!=clock

Can be used with most kubectl commands.

Other ways to get the labels:
kubectl get --show-labels po,rs,deploy,svc,no

## Differences between labels and annotations
The key for both labels and annotations:

    must start and end with a letter or digit

    can also have . - _ (but not in first or last position)

    can be up to 63 characters, or 253 + / + 63


Label values are up to 63 characters
Annotations values can have arbitrary characters (yes, even binary)

Maximum length isn't defined

# Kube Logs
kubectl logs only shows the logs of one of the pods.
View the last line of log from all pods with the app=pingpong label:

kubectl logs -l app=pingpong --tail 1
The logs can only be streamed for 5 pods.
There are external tools to address these shortcomings.
Stern https://github.com/wercker/stern

## Stern
https://container.training/kube-selfpaced.yml.html#212