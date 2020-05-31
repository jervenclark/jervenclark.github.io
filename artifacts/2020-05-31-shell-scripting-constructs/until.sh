#!/bin/bash

n=0

until [ $n -gt 10 ]
do
    echo $n
    ((n++))
done
