#!/bin/bash

/bin/bash -c 'apt update && apt install cron mc -y && service cron start'

#sudo /bin/bash -c 'echo "0 * * * * root /scripts/mysql_backup.sh" >> /etc/crontab'
/bin/bash -c 'echo "0 * * * * root /scripts/mysql_backup.sh" >> /etc/crontab'
#sudo /bin/bash -c 'echo "0 * * * * root /code/backdb.sh" >> /etc/crontab'

#/bin/bash -c 'apt update && apt install cron mc -y && service cron start'