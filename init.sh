#!/bin/bash

#parse to string
read -a IN <<< $IN
read -a OUT <<< $OUT

#validation
if [ ${#IN[@]} -ne ${#OUT[@]} ];
then
  echo "${date -I'seconds'} [ERR] IN/OUT mismatch"
  exit 1
fi
if [ -z USER ] || [ -z PASS ] || [ -z URL ]; then
  echo "${date -I'seconds'} [ERR]: Missing params"
  exit 1
fi


mkdir sync
for ((i = 0 ; i <= ${#IN[@]}-1 ; i++)); do
	echo $(date -I'seconds') "- List ${IN[$i]} >> ${OUT[$i]}"
	unison -batch -confirmbigdel=false ./media/${IN[$i]}/ ./sync/${OUT[$i]}/
done;
while true
do
#mkdir sync
	$( [ "$MUTE" = "false" ] ) && ls sync/ -hR
	echo $(date -I'seconds') "- Uploading";
	nextcloudcmd $( [ "$MUTE" = "true" ] && echo "--silent" ) \
		-u ${USER} -p ${PASS} ./sync ${URL}
	[ $? -eq 0 ] || echo $(date -I'seconds') "- [ERR] upload error"
	$( [ "$MUTE" = "false" ] ) && ls sync/ -hR 
	for ((i = 0 ; i <= ${#IN[@]}-1 ; i++)); do
		echo $(date -I'seconds') "- Download ${OUT[$i]} << ${IN[$i]}"
		unison -batch -confirmbigdel=false ./sync/${OUT[$i]}/ ./media/${IN[$i]}/
	done;
	echo $(date -I'seconds') "- Next sync in ${SLEEP}"
	sleep $SLEEP
done