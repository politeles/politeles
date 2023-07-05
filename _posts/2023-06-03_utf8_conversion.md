# UTF-8 migration in SQL

Current db is encoded in latin1, the database is mysql 5.7

The steps are as follows:
 - Change the overal character set and collation for mysql.
 - Update the default values for the date fields for each table.
 - Alter each table character set and collation.
 - Dump database.

## Change db character set
 
```sql
alter database databasename character set utf8 COLLATE utf8_unicode_ci;
```

## Alter default date
Some documentation from mysql.[https://dev.mysql.com/doc/refman/8.0/en/data-type-defaults.html#data-type-defaults-explicit-old]
```sql
alter table tablename alter column columname set default '2023-06-03';
```

you can update the default value to a formula. In this case, the current date is fine.

## Convert the table to utf8

```sql
ALTER TABLE actuaciones CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```

execute as script:

```
mysql> source altertables.sql
```

## Dump database

```sql
mysqldump -u username -p databasename > export.sql
```

## Conversion of files in powershell
Just in case you want to convert to utf8 code files.
In this example, we are converting php files.

```
foreach($i in ls -recurse -filter "*.php") {
    $temp = Get-Content $i.fullname
    Out-File -filepath $i.fullname -inputobject $temp -encoding utf8 -force
}
```

## in php the enemy of BOM

https://cybmeta.com/cannot-modify-header-information-headers-already-sent