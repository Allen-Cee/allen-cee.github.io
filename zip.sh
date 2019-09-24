#!/usr/bin/expect

spawn zip -ej /Users/Aoi/Documents/Code/allen-cee.github.io/网络/shadowsocks/shadowsocks_profiles.zip /Users/Aoi/Desktop/shadowsocks_profiles.txt
expect "Enter password:"
send "cyys1909\r"
expect "Verify password:"
send "cyys1909\r"
interact

spawn zip -ej /Users/Aoi/Documents/Code/allen-cee.github.io/黑流投资/流形一期/流形一期公告净值.zip /Users/Aoi/Desktop/Quant/fund/黑流/流形一期/流形一期公告净值.csv
expect "Enter password:"
send "tlms0515\r"
expect "Verify password:"
send "tlms0515\r"
interact
