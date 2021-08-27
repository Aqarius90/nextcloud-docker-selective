#!/bin/bash

#parse to string
read -a IN <<< $IN
read -a OUT <<< $OUT

#validation
if [ ${#IN[@]} -ne ${#OUT[@]} ];
then
  echo "[ERR] IN/OUT mismatch"
  exit 1
fi


mkdir sync
while true
do
#mkdir sync
	#	nextcloud $( [ "$MUTE"==true ] && echo "--silent" ) \
	#	 	-u ${USER} -p ${PASS} \
	#		/nextcloud/${IN[$i]} \
	#		 ${URL}/remote.php/webdav/${OUT[$i]}
	for ((i = 0 ; i <= ${#IN[@]}-1 ; i++)); do
		echo "Sync ${IN[$i]} to ${OUT[$i]}"
		rsync -r --delete ./media/${IN[$i]}/ ./sync/${OUT[$i]}/
	done;
	nextcloudcmd $( [ "$MUTE" -eq true ] && echo "--silent" ) \
		-u ${USER} -p ${PASS} ./sync ${URL}
	for ((i = 0 ; i <= ${#IN[@]}-1 ; i++)); do
		echo "Sync ${OUT[$i]} to ${IN[$i]}"
		rsync -r --delete ./sync/${OUT[$i]}/ ./media/${IN[$i]}/
	done;
	echo "Next sync in ${SLEEP}"
	sleep $SLEEP
# rm -rf sync
done