#!/bin/bash

DATE=$(date +%Y%m%dT%H%M%S)

/usr/local/bin/etcd-snapshot-backup-disconnected.sh /assets/backup

if [ $? -eq 0 ]; then
    mkdir /etcd-backup/${DATE}
    cp -r /assets/backup/*  /etcd-backup/${DATE}/
    if [ $? -eq 0 ]; then
    # Making sure we exit clean witout errors only if the cp command is
    # successful
        echo 'Copied backup files to PVC mount point.'
        echo 'Removing backups older than 5 days.'
        find /assets/backup/* -type d -ctime +5
        find /assets/backup/* -type d -ctime +5 -exec rm -rf {} \;
        exit 0
    fi
fi

echo "Backup attempts failed. Please FIX !!!"
exit 1
