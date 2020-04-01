
# Nodejs

首先升级一下yum

```bash
yum -y update
```

查看是否已经安装EPEL

```bash
yum info epel-release
```

安装EPRL源后就可以安装Nodejs了

```bash
sudo yum install nodejs
```

安装完成后，通过`node -v` 查看当前安装的版本，一般都是安装的V6的，版本比较低，需要升级Nodejs

安装n管理Nodejs版本

```bash
npm install -g n
```

然后就可以使用指令n来安装node.js版本了

```bash
#安装最新版本
n latest

#安装指定版本
n 12.13.1
```

使用n切换node.js版本
命令行输入`n`，上下键选择已经安装的Nodejs版本，回车键选定版本
