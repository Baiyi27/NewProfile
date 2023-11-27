#!/bin/bash

# 主文件夹路径
mainDir="/mnt/hgfs/"

# 文件夹列表
folders=("DebugDtools" "Dtools" "Pro" "VMshare" "PlcDriver")

# 软链接名列表
#symlinks=("DebugDtools" "Dtools" "Pro" "VMshare" "PlcLib")

# 遍历文件夹列表

for item in "${folders[@]}"; do

    ln -s "$mainDir$item" "${item}lib.lnk"

    echo "Created symlink for $item->${item}lib.lnk"
done
