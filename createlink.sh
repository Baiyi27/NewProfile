#!/bin/bash

# 主文件夹路径
mainDir="/mnt/hgfs/"

# 文件夹列表
folders=("DebugDtools" "Dtools" "Pro" "VMshare")

# 软链接名列表
#symlinks=("DebugDtoolslib.lnk" "Dtoolslib.lnk" "Prolib.lnk" "VMshare.lnk")

# 遍历文件夹列表

for item in "${folders[@]}"; do

    ln -s "$mainDir$item" "${item}lib.lnk"

    echo "Created symlink for $item->${item}lib.lnk"
done
