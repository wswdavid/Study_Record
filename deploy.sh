#!/bin/bash

echo "Start deployment"
#填写项目所在的目录地址
WEB_PATH='#填写项目所在的目录地址'

echo $WEB_PATH
cd $WEB_PATH

echo "pulling source code..."
git reset --hard origin/master
git clean -f
git pull
git checkout master

echo "start build"
gitbook build
echo "Finished."