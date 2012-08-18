#!/bin/bash

if [ "$#" -ne "1" -o "$1" = "-h" -o "$1" = "--help" ]
then
	echo "Usage: $0 /path/to/folder"
	echo "The argument should be the path to the folder in which the 'git init' command was executed."
	exit 1
elif [ ! -d "$1" ]
then
	echo "Directory does not exist!"
	echo "Usage: $0 /path/to/folder"
	exit 1
fi

#find binary files, display and store in temp
echo "Binary files found:"
find "$1" -path '*/.git/*' -or -executable -type f -printf "%P\n" | tee temp

#add lines in temp to gitignore if they don't already exist
cat temp | while read line
do
	grep "^$line$" "$1/.gitignore" &>/dev/null || echo "$line" >> "$1/.gitignore"
done

rm -f temp
