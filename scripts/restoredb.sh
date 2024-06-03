#!/bin/bash

userDB="root"
passwordDB="db-btf5q"

dirbak='/backup/mysql'
#dirvol='/var/lib/docker/volumes/otus-volume/_data'
dirtmp='/backup/temp'

test -d $dirtmp || mkdir -p $dirtmp


l=`find /backup/mysql -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | grep "/backup/mysql/20" | head -n 1 | cut -d ' ' --complement -f1,2 | cut -d '/' --complement -f1,2,3,4 | cut -d '.' --complement -f3`
namedb=`find /backup/mysql -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | grep "/backup/mysql/20" | head -n 1 | cut -d ' ' --complement -f1,2 | cut -d '/' --complement -f1,2,3,4 | cut -d '.' --complement -f3 | cut -d '-' --complement -f2,3,4`

lfile=`find /backup/mysql -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | grep "/backup/mysql/20" | head -n 1 | cut -d ' ' --complement -f1,2 | cut -d '/' --complement -f1,2,3,4`
lpath=`find /backup/mysql -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | grep "/backup/mysql/20" | head -n 1 | cut -d ' ' --complement -f1,2 | cut -d '/' --complement -f5`

#echo "======================"
#echo $l
#echo "ll = $ll"
#p= `echo $l | cut -d '-' --complement -f2,3,4`
#echo "p = $p"
#echo $lfile
#echo $lpath
#echo "======================"

cd $lpath
#tar -C ../. -xvf $lfile
#gzip  $lpath/$lfile -d $dirtmp
gzip  -d $lfile
cp *.sql $dirtmp
rm -f $l

#ll=

#if [[ -d "$dirbak" && -d "$dirvol" ]] ; then
#    echo "======================"
#    echo $dirbak/db.sqlite3
#    echo $dirvol/db.sqlite3
#    echo "======================"
#fi


echo  $lpath/$l
mysql -u$userDB -p$passwordDB $namedb < $dirtmp/$l

rm -f $dirtmp/$l