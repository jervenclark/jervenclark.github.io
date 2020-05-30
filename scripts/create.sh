#!/bin/sh

while getopts ":t:a:d:" opt; do
    case $opt in
        t) title=$(sed -E 's/(\s+)/ /g' <<< "$OPTARG")
           ;;
        a) tags="$OPTARG"
           ;;
        d) desc="$OPTARG"
           ;;
        s) series="$OPTARG"
           ;;
        \?) echo "Invalid option -$OPTARG" >&2
            ;;
    esac
done


date=$(date '+%Y-%m-%d')
time=$(date '+%H:%M:%S %z')
datetime="$date $time"
permalink=$(sed -E "s/(\s+)/-/g;s/(.*)/\L\1/" <<< $title)

sed -E "s/TITLE/$title/;s/DATETIME/$datetime/;s/TAGS/$tags/;s/DESC/$desc/;s/SERIES/$series/" \
    _posts/template.md > _posts/$date-$permalink.md
