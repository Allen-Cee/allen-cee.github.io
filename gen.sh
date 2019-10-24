#!/bin/bash

cd /Users/Aoi/Documents/Code/allen-cee.github.io/
python3 /Users/Aoi/Desktop/Quant/fund/黑流/流形一期/convert.py
#/Users/Aoi/Documents/Code/allen-cee.github.io/zip.sh
zip -ejo /Users/Aoi/Documents/Code/allen-cee.github.io/network/shadowsocks/shadowsocks_profiles.zip /Users/Aoi/Desktop/shadowsocks_profiles*.txt -P cyys1909
zip -ejo /Users/Aoi/Documents/Code/allen-cee.github.io/investment/black_current/manifolds_I/manifolds_I-net_value.zip /Users/Aoi/Desktop/Quant/fund/黑流/流形一期/流形一期公告净值.csv -P tlms0515

function GenerateIndexFile()
{
    file_path=$(pwd)
    echo $file_path
    files=$(ls -F)
    main=index.html
    cat /dev/null > $main
    printf "<html>\n<head>\n<title>Index of "${file_path:45}"/</title>\n<body bgcolor=\"white\">\n<h1>Index of "${file_path:45}"/</h1>\n<hr>\n<pre>\n" > $main
    printf "<a href=\"../\">../</a>\n" >> $main
    for f in $files; do
        if [ $f != 'index.html' ] && [ $f != 'gen.sh' ] && [ $f != 'zip.sh' ] && [ $f != 'README.md' ]; then
            f=${f/' '/'_'}
            time=$(date -r $f '+%d-%b-%Y %H:%M')
            size='-'
            if [ -f $f ]; then
                size=$(stat -f %z $f)
                if [ ${#f} -gt 50 ]; then
                    f=${f:0:47}'..>'
                fi
            fi
            printf '%-'$[65+${#f}]'s %s %20s\n' '<a href="'$f'">'$f'</a>' "$time" "$size" >> $main
        fi
    done
    printf "</pre>\n</hr>\n</body>\n</html>\n" >> $main

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
echo 'Generate complete'

git add .
git commit -m "update" -a
git push allen-cee master
