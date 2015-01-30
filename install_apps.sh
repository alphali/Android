#!/bin/sh
# 安装其他App
i=0
while read app 
do
    packages[$i]=$app
    let i++
    echo $i
done < apps.txt
download_dir="/usr/android/apk"
install_dir="/usr/android/platform-tools/adb"

let i--
while [ $i -ge 0 ]; do
    package=${packages[$i]}
    file=$download_dir/$package.apk
    let i--
    if [[ -f $download_dir/$package.apk ]]
    then
        $install_dir install -r $file
        continue
    fi
    #package=com.cnn.mobile.android.phone
    wget "http://apps.wandoujia.com/apps/$package/download" -O $file
    if [[ -f $file ]]
    then
        $install_dir install -r $file
    fi 
done
