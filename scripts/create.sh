#!/bin/sh

# Defaults
date=$(date '+%Y-%m-%d')
time=$(date '+%H:%M:%S %z')
datetime="$date $time"
format='markdown'

# Process arguments
while getopts ":t:a:d:s:f:" opt; do
    case $opt in
        t) title=$(sed -E 's/(\s+)/ /g' <<< "$OPTARG")
           permalink=$(sed -E "s/(\s+)/-/g;s/(.*)/\L\1/" <<< $title)
           ;;
        a) tags="$OPTARG"
           ;;
        d) desc="$OPTARG"
           ;;
        s) series="$OPTARG"
           ;;
        f) format="$OPTARG"
           ;;
        \?) echo "Invalid option -$OPTARG" >&2
            ;;
    esac
done

if [ $format = 'jupyter' ]
then
    extension='ipynb'
    directory='_jupyter'
else
    extension='md'
    directory='_posts/'
fi


sed -E "s/TITLE/$title/;s/DATETIME/$datetime/;s/TAGS/$tags/;s/DESC/$desc/;s/SERIES/$series/" \
    'scripts/template'.$extension > $directory/$date-$permalink.$extension
