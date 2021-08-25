if [ ${#IN[@]} -ne ${#OUT[@]}] ; then
  echo "[ERR] IN/OUT mismatch" | ts "${LOG_DATE_FORMAT}"
  exit 1
fi

while true
do
	for ((i = 0 ; i <= ${#IN[@]} ; i++)); do
  		echo "$IN[$i]"
		echo "$OUT[$i]"
	done;
	#nextcloudcmd $( [ "$MUTE" == true ] && echo "--silent" )\
	#	-u $USER -p $PASS /media/nextcloud/ $URL\
	echo "Next sync in ${SYNC}"
	sleep $SLEEP
done