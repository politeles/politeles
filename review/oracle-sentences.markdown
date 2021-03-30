# Oracle common sentences:

## Archive log:

```sql
SQL> SELECT LOG_MODE FROM SYS.V$DATABASE;

LOG_MODE
------------
NOARCHIVELOG

```

Change archive log mode:

```sql
SQL> alter database archivelog;
Database altered.

SQL> alter database open;
Database altered.

```


## Switch Redo logs:

```sql

alter system switch logfile;

```