#!/bin/bash

if [[ -z "$1" ]]
then
    FILE="input.txt";
else
    FILE=$1;
fi

echo $FILE | a68g day_10.a68