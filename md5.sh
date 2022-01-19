#!/bin/bash
###########################################################
#  description: compare many files one time               #
#  author     : 骏马金龙                                   #
#  blog       : http://www.cnblogs.com/f-ck-need-u/       #
###########################################################

# filename: md5.sh
# Usage: $0 file1 file2 file3 ...

# find . -type f -name "*.css" -print0 | xargs -0 ./md5.sh

IFS=$'\n'
declare -A md5_array

# If use while read loop, the array in while statement will
# auto set to null after the loop, so i use for statement
# instead the while, and so, i modify the variable IFS to
# $'\n'.

# md5sum format: MD5  /path/to/file
# such as:80748c3a55b726226ad51a4bafa1c4aa /etc/fstab
for line in `md5sum "$@"`
do
    index=${line%% *}
    file=${line##* }
    md5_array[$index]="$file ${md5_array[$index]}"
done

# Traverse the md5_array
for i in ${!md5_array[@]}
do
    echo -e "the same file with md5: $i\n--------------\n`echo ${md5_array[$i]}|tr ' ' '\n'`\n"
done 
