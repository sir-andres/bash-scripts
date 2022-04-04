#!/bin/bash

backup_folder=$HOME/backup_folder
archive=(backup_$(date "+%Y%m%d").gz)
path_to_backup=/etc
file_backup=$1

#check if enought arguments
if [ $# -ne 1 ]
then
        echo "Please provide archive name as an argument"
        exit 1
fi

#check if directory exists
mkdir -p $backup_folder

#check and delete backup's older 7 days
find $backup_folder -type f -mtime +7 -delete

#check if archive already exist in $backup_folder

if [ -f $backup_folder/$archive ]
then
        echo "File $archive already exists."
        exit 1
fi

#making backup file
if [ $path_to_backup != $file_backup ]
then
        tar -cvzf $backup_folder/$archive $file_backup
        #tar --exclude '*.txt' -cvzf $backup_folder/$archive $file_backup
        echo "$archive $file_backup was created" && exit 0
else
        echo "$archive $file_backup wasn't created"
fi

if [ $file_backup = $path_to_backup ]
then
        tar -cvzf $backup_folder/$archive $path_to_backup
        echo "$archive $path_to_backup was created"
else
        echo "$archive $path_to_backup wasn't created"
        exit 1
fi

#form for --exclude '*.txt' '*.jpeg' '*.???x'
