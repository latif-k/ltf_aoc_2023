#!/bin/bash

script_name=$1
sample_file=$2

# check that all variables are defined
if [ -z "$script_name" ] || [ -z "$sample_file" ]; then
	echo "Usage: $0 <script_name> <sample_file>"
	exit 1
fi

lines=$(awk '{print $1}' "$sample_file")

diff_res=$(sdiff \
	-l \
	--ignore-blank-lines \
	--ignore-trailing-space \
	<(awk -v debug=1 -f $script_name <(echo "$lines")) \
	$sample_file | cat -n | grep "|")
echo "line number / run result / digit file"
echo "$diff_res"
# check last command status
if [ $? -ne 0 ]; then
	echo "Test failed."
	exit 0
else
	echo "Okay"
	exit 0
fi
