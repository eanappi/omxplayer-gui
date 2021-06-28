#!/usr/bin/bash
file=$(zenity --file-selection --title='Open file')

if [ "$file" = "" ]
then
  exit 1
fi

size=$(zenity --scale --title='Size window' --value=1 --min-value=1 --max-value=5 --step=1)

if [ -z $size ]
then
  exit 1
fi

resolutionRaw=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
resolutionY=$(expr ${resolutionRaw#*x} / $size)
resolutionX=$(expr ${resolutionRaw%x*} / $size)
echo "Resolution: ${resolutionX}x${resolutionY}"
omxplayer -o both --vol -2500 --aspect-mode fill --win 0,0,${resolutionX},${resolutionY} "$file"
exit 1
