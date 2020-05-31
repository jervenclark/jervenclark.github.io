#!/bin/bash

echo -n "provide a number: "
read n
if [ $(($n % 2)) -eq 0 ]
then
    echo 'Number is greater even'
else
    echo 'Number is greater odd'
fi
