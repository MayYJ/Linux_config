#!/bin/bash

jdk_path="/bin/java/jdk8"
jdk_tar_path="/tmp/jdk-8u181-linux-x64.tar.gz"
if [ ! -e "$jdk_tar_path"]
then
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /tmp http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
    echo "成功下载了jdk压缩包"
else
    echo "/tmp 路径下已经存在了jdk压缩包"
fi

if [ ! -d "$jdk_path" ]
then
    mkdir /bin/java
    mkdir /bin/java/jdk8
    tar -zxvf /tmp/jdk-8u181-linux-x64.tar.gz -C /bin/java/jdk8 --strip-components 1
	rm /tmp/jdk-8u181-linux-x64.tar.gz
else
    echo "/bin/java/jdk8 路径下似乎已经含有jdk包"
fi

read -p "Do you want to continue? [Y/N]" answer
case $answer in
N | n)
      exit
      ;;
Y | y)
      java_config_str='export JAVA_HOME=/bin/java/jdk8\nexport JRE_HOME=${JAVA_HOME}/jre\nexport CLASSPATH=.:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib/dt.jar\nexport PATH=${JAVA_HOME}/bin:${JAVA_HOME}/jre/bin:$PATH'
      #判断是否有java环境变量，有环境变量再配置会造成不能配置成功
      java_home="JAVA_HOME"
      if cat /etc/profile | grep "$java_home">/dev/null
      then
          echo "请在/etc/profile中查看是否已经配置了java环境变量"
        else
          echo -e $java_config_str >> /etc/profile
          source /etc/profile
          echo "java 环境变量配置完成"
      fi
      ;;
*)
      echo "error choice"
esac
exit 0
