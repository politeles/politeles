# Reusing docker desktop 

After some time doing experiments on kubernetes, I want to work in docker for windows using kubernetes.
[Docker for desktop documentation](https://docs.docker.com/desktop/kubernetes/).

Open a terminal

```cmd
PS C:\Users\polit> kubectl config get-contexts
CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
          docker-desktop   docker-desktop   docker-desktop
*         dppizza          dppizza          dppizza          default


```

and change the current to point to docker-desktop.

```cmd
PS C:\Users\polit> kubectl config use-context docker-desktop
Switched to context "docker-desktop".
```

