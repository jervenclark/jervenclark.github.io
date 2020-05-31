#!/bin/bash

for fruit
in $*
do
    echo "The name of the fruit is $fruit"
    uppercase=`sed -E 's/(\w+)/\U\1/' <<< $fruit`
    echo "The uppercase name is $uppercase"
    echo
done
