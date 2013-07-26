#!/bin/bash
 
DATESTAMP=`date +%Y%m%d`
TIMESTAMP=`date +%H%M`
LOGFILE="/var/log/ebs_backup.log"
 
VOLUMES=( vol-bb797fe1 )
 
echo "TIGERFISH EBS BACKUP $DATESTAMP $TIMESTAMP" 2>&1 | tee -a $LOGFILE
echo " " 2>&1 | tee -a $LOGFILE
 
# Create a snapshot of each volume.
for volume in ${VOLUMES[@]}
do
 php CreateSnapshot.php -v $volume  2>&1 | tee -a $LOGFILE
done
 
# Remove older snapshots we don't need to keep any more.
for volume in ${VOLUMES[@]}
do
 php ec2-manage-snapshots.php -v $volume 2>&1 | tee -a $LOGFILE
done
