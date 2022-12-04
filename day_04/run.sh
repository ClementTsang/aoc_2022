#!/bin/bash

if [[ -z "$1" ]]
then
    FILE="input.txt";
else
    FILE=$1;
fi

echo "Using $FILE"
gforth day_04.fs < $FILE