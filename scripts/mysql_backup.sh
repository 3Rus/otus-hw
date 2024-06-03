#!/bin/bash
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

destination="/backup/mysql"
userDB="root"
passwordDB="db-btf5q"
fdate=`date +%Y-%m-%d`
ftime=`date +%H-%M-%S`

find $destination -type d \( -name "*-1[^5]" -o -name "*-[023]?" \) -mtime +30 -exec rm -R {} \; 2>&1
find $destination -type d -name "*-*" -mtime +180 -exec rm -R {} \; 2>&1
test -d $destination/$fdate || mkdir -p $destination/$fdate

for dbname in `echo show databases | mysql -u$userDB -p$passwordDB | grep -v Database`; do
    case $dbname in
        information_schema)
            continue ;;
        mysql)
            continue ;;
        performance_schema)
            continue ;;
        test)
            continue ;;
        sys)
            continue ;;
        *) mysqldump --databases --skip-comments --no-tablespaces -u$userDB -p$passwordDB $dbname | gzip > $destination/$fdate/$dbname-$ftime.sql.gz ;;
    esac
done;