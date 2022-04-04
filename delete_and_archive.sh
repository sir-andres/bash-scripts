#!/bin/bash

TRASH=$HOME/TRASH
file="$1"
archivename="$file".gz (archive-$(date "+%Y%m%d").gz)

#check if enought arguments

if [ $# -ne 1 ]
then
        echo "Please provide archive name as an argument"
        exit 1
fi

#check if directory exists

mkdir -p $TRASH

#check and delete files/directories older 48 hours

find $TRASH -type f -mtime +2 -delete
find $TRASH -type d -mtime +2 -delete

#check if initial files exist

if [ ! -f $file ]
then
        echo "File $file does not exist"
        exit 1
fi

#check if archive already exist in TRASH

if [ -f $TRASH/$archivename ]
then
        echo "File $archivename already exists. You can't delete $file"
        exit 1
fi

#check if $file is symlink or not. And delete it if yes

if [ -L $file ]
   then
           echo "Original file of symlink is" && readlink -f $file
           rm $file && echo "It was deleted only symlink of $file"
           exit 0
fi

#check if $file is hardlink

find -samefile $file && echo "$file is hardlink"

#archive and delete $file

gzip -c $file > $TRASH/$archivename && rm $file && echo "$file was moved to $TRASH" || echo "Somthing went wrong!"
