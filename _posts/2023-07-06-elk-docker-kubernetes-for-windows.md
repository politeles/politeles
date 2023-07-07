# Setting up ELK stack on Kubernetes in docker for windows.

First of all, I'm installing [Helm][helm] from the releases page, the windows version. I copied to the typical windows program files folder and updated the PATH environment variable to check the new helm folder. So now I can use it in console.
I studied the following tutorials: 
(https://blog.knoldus.com/how-to-deploy-elk-stack-on-kubernetes/
https://tharangarajapaksha.medium.com/)(elk-stack-in-k8s-cluster-13bb509185e0)
(https://www.cloudsigma.com/installing-software-on-kubernetes-with-helm-3-package-manager-on-windows/)


I'm going to [create a new namespace in the k8s cluster][nsp] for elk stak.

```powershell
kubectl create namespace elk
``` 

Because I have Helm, I'm going to [install the ingress controller][ingress] using the following command:

```powershell
helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx   --namespace ingress-nginx --create-namespace
```



Now I'm going to install the helm chart for elasticsearch, I'm using the default values, but I'm going to change the name of the release to elk.

I'm using the guide from elastic.co [here][eck-k8s]

```powershell
kubectl create -f https://download.elastic.co/downloads/eck/2.8.0/crds.yaml
```

Now, I'm going to install the operator, which is the one that will create the elasticsearch cluster.

```powershell
kubectl apply -f https://download.elastic.co/downloads/eck/2.8.0/operator.yaml
```

Monitor the operator deployment until it is ready:

```powershell
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
```

Now, I'm going to apply the operator configuration, which is the one that will create the elasticsearch cluster.

Create a file with the following content:

```yaml
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 8.8.2
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
```

and now apply it:

```powershell
kubectl apply -f elasticsearch.yaml
```

It will take a while to be available, you can check the status with the following command:

```powershell
kubectl get elasticsearch
```

and the output:

```powershell	
NAME         HEALTH    NODES   VERSION   PHASE             AGE
quickstart   unknown           8.8.2     ApplyingChanges   46s
```

when it's ready, the output will be:

```powershell	
NAME         HEALTH   NODES   VERSION   PHASE   AGE
quickstart   green    1       8.8.2     Ready   2m38s
```	


You can check the pods with the following command:

```powershell
kubectl get pods --selector='elasticsearch.k8s.elastic.co/cluster-name=quickstart'
```	

## Request Elasticsearch access
first, check the cluster IP:
```powershell
kubectl get service quickstart-es-http
```

Next, get the credentials (you can use powershell)
```powershell
$PASSWORD = kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
```

or you can use cmd:
```cmd
curl -u "elastic:$PASSWORD" -k "https://localhost:9200"
{
  "name" : "quickstart-es-default-0",
  "cluster_name" : "quickstart",
  "cluster_uuid" : "WWtwSzimREaMT38n65lghA",
  "version" : {
    "number" : "8.8.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "98e1271edf932a480e4262a471281f1ee295ce6b",
    "build_date" : "2023-06-26T05:16:16.196344851Z",
    "build_snapshot" : false,
    "lucene_version" : "9.6.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Kibana
To deploy Kibana, we use the following file:

```yaml
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: quickstart
spec:
  version: 8.8.2
  count: 1
  elasticsearchRef:
    name: quickstart
```

The command to apply it is:

```powershell
kubectl apply -f .\kibana.yaml
```	

Check the status and wait until it's ready:

```powershell
kubectl get kibana
```

The output will be:

```powershell
NAME         HEALTH   NODES   VERSION   AGE
quickstart   red              8.8.2     38s
```

When it's ready, the output will be:

```powershell
quickstart   green    1       8.8.2     4m9s
```

Check the pods:
  
```powershell
kubectl get pod --selector='kibana.k8s.elastic.co/name=quickstart'
```

The output will be:

```powershell
NAME                             READY   STATUS    RESTARTS   AGE
quickstart-kb-66fb9f8b65-bsdp7   1/1     Running   0          5m20s
```
Now, check the service:

```powershell
kubectl get service quickstart-kb-http
```

The output will be:

```powershell
NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
quickstart-kb-http   ClusterIP   10.111.153.143   <none>        5601/TCP   5m40s
```

You can now forward the port
  
 ```powershell
 kubectl port-forward service/quickstart-kb-http 5601
```

Get the password:

```powershell
kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | %{[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_))};
```
It's the same as the elasticsearch password.
Anyway, let's connect to the web interface, open a browser and go to http://localhost:5601






[helm]: https://github.com/helm/helm/releases
[nsp]: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
[ingress]: https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
[eck-k8s]:https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html
[port-forwarding-docker]:https://medium.com/@lizrice/accessing-an-application-on-kubernetes-in-docker-1054d46b64b1