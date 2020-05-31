#!/bin/bash

echo -n "provide a number: "
read n
if [ $n -gt 10 ]
then
    echo 'Number is greater than 10'
fi
