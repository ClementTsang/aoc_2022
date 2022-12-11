#!/bin/bash

if [[ -z "$1" ]]
then
    FILE="input.txt";
else
    FILE=$1;
fi

echo "Using file $FILE" 

fpc day_11.pp && ./day_11 < $FILE