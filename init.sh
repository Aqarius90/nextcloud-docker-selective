#!/bin/bash
IN=("ss1w", "2", "3", "4");
OUT=("2", "3", "4", "0");
echo ${#IN[@]}
echo ${#OUT[@]}
if [ ${#IN[@]} -ne ${#OUT[@]} ];
then
  echo "[ERR] IN/OUT mismatch"
  exit 1
fi

#while true
#do
	for ((i = 0 ; i <= ${#IN[@]}-1 ; i++)); do
		echo "Sync ${IN[$i]} to ${OUT[$i]}"
		nextcloudcmd $( [ "$MUTE" ] && echo "--silent" ) \
			-u ${USER} -p ${PASS} \
			/media/nextcloud/${IN[$i]} \
			 ${URL}/nextcloud/remote.php/webdav/${OUT[$i]}
	done;
	#nextcloudcmd $( [ "$MUTE" == true ] && echo "--silent" )\
	#	-u $USER -p $PASS /media/nextcloud/ $URL\
	echo "Next sync in ${SLEEP}"
	sleep $SLEEP
#done