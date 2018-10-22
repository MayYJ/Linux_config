#!/bin/bash

# 检查java环境
a=`cat /etc/profile | grep JAVA_HOME | head -n 1`

if [ -n "$a" ]
then
    echo "java environment is not configed!  please config it first!"
    exit 0
fi


tomcat_path="/opt/tomcat8"
tomcat_tar_path="/tmp/apache-tomcat-8.5.34.tar.gz"
if [ ! -e "$tomcat_tar_path" ]
then
    wget -P /tmp https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.34/src/apache-tomcat-8.5.34-src.tar.gz
else
    echo "/tmp 目录下已经存在tomcat8 压缩包"
fi

if [ ! -d "$tomcat_path" ]
then
    mkdir /opt/tomcat8
    tar -zxvf /tmp/apache-tomcat-8.5.34.tar.gz -C /opt/tomcat8 --strip-components 1
    rm /tmp/apache-tomcat-8.5.34.tar.gz
    echo "tomcat8 已经安装在/opt/tomcat8下"
else
    echo "检查 tomcat 是否已经安装在 /opt/tomcat8下， 或者删除/opt/tomcat8文件"
fi

exit 0
