#!/bin/bash

cd /Users/Aoi/
function GenerateIndexFile()
{
    file_path=$(pwd)
    echo $file_path
    files=$(ls -F)
    if [ -f $file_path/index.html ]; then
        rm $file_path/index.html;
    fi

    for f in $files; do
        if [ -d $f ]; then
           cd $f;
           #file_path=$(pwd)
           GenerateIndexFile;
           cd ..;
        fi
    done
}

GenerateIndexFile;
echo 'rm complete'
