# Extend tablespace for PEX:
Check Total Size:


```sql


WITH ddf_mio AS
    (
        SELECT file_id, tablespace_name, file_name,
               DECODE (autoextensible,
                       'YES', GREATEST (BYTES, maxbytes),
                       BYTES
                      ) mysize,
              DECODE (autoextensible,
                      'YES', CASE
                         WHEN (maxbytes > BYTES)
                            THEN (maxbytes - BYTES)
                         ELSE 0
                      END,
                      0
                     ) growth
         FROM dba_data_files)
SELECT   ddf_mio.tablespace_name,
         ROUND (SUM (ddf_mio.mysize) / (1024 * 1024)) TOTALSIZE,
         ROUND (SUM (growth) / (1024 * 1024)) FREE_X_AUTOEXTEND,
         ROUND ((SUM (NVL (freebytes, 0))) / (1024 * 1024)) FREE_ACTUAL,
         ROUND ((SUM (NVL (freebytes, 0)) + SUM (growth)) / (1024 * 1024)
               ) TOTALFREE,
         ROUND (  (SUM (NVL (freebytes, 0)) + SUM (growth))
                 / SUM (ddf_mio.mysize)
                 * 100
               ) PCT_FREE
    FROM ddf_mio, (SELECT   file_id, SUM (BYTES) freebytes
                      FROM dba_free_space
                  GROUP BY file_id) dfs
   WHERE ddf_mio.file_id = dfs.file_id(+)
         AND ddf_mio.tablespace_name NOT LIKE '%UNDOTB%'
GROUP BY ddf_mio.tablespace_name
ORDER BY 6 DESC;


```


Check data file sequence:


```SQL


select file_name, file_id, tablespace_name from dba_data_files where TABLESPACE_NAME like '%WEBMDATA%' order by file_id;

```

Add datafile:

```SQL

alter tablespace WEBMDATA add datafile '/oracle/PWQ/oradata/webmdata.data46' size 500M autoextend on next 50M maxsize 10000M;

```