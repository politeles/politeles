# PEX typical problems on Mysql:

# timeouts
Most of the time are due to a table lock
Unlock all tables:

```sql
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;

``` 

# one host is not allowed to use a db:
for bms on test environment:

```sql


grant all privileges on bms.* to 'bms'@'pyxrrtap0%.pyx.erp'  identified by '******';

``` 
The wild card on the hostname pyxrrtap0%.pyx.erp ensures all test app servers will connect.


# Health check:

Innodb status 

```sql
SHOW ENGINE INNODB STATUS;
```

Maximum allowed connections:

```sql
SHOW GLOBAL VARIABLES LIKE 'max_connections';
SHOW GLOBAL STATUS LIKE 'max_used_connections';
```  