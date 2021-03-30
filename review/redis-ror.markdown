# Redis troubleshooting guide

## Check Master / Slave status OS level:

```bash

redis-cli -h pyxreqap01 -p 17700 SENTINEL get-master-addr-by-name redis-pex-01
1) "10.50.131.31"
2) "6379"

```

## Check Redis status:
```bash

redis-cli -h pyxrepap01 -p 17700 INFO

```