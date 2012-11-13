#!/bin/bash
# Capture a new image from the webcam and stick 
# it in the appropriate DATE.dir with the right name

IMGTHRESHOLD="0.85"

DATEFOLDER="$(date +%Y-%m-%d).d"
FILENUM=0

# Find the index of the last capture
if [ -d $DATEFOLDER ] ; then
	LASTNUM=$(ls $DATEFOLDER | grep .jpg | sort | tail -n1 | cut -d. -f1)
	FILENUM=$(expr $LASTNUM + 1)
fi

FILENAME=${DATEFOLDER}/"$(printf %05d $FILENUM).jpg"

mkdir -p "$DATEFOLDER"
fswebcam -q -r 1280x720 "$FILENAME" > /dev/null

# Compare with the last capture and delete if close enough
if [ "$LASTNUM" ] ; then
	LATFILENAME=${DATEFOLDER}/${LASTNUM}.jpg
	IMAGEDIFF=$(compare -metric NCC $LATFILENAME $FILENAME /dev/null 2>&1)
	CLOSEENOUGH=$(echo "$IMAGEDIFF > $IMGTHRESHOLD" | bc -l)

	if [ "$CLOSEENOUGH" -eq "1" ] ; then
		rm "$FILENAME"
	fi
fi

# If we kept the capture, tag it
#if [ -f "$FILENAME" ] ; then
#	convert ${FILENAME} -font Helvetica -annotate 0 "$(date)" ${FILENAME}
#fi
