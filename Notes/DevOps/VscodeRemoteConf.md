<!-- toc -->

# 云服务器配置 Remote SSH

## 1.在本地机器生成密钥对

`ssh-keygen -t rsa`

一路 Enter 到底

## 2.将公钥拷贝到服务器

1. 本机拷贝秘钥文件至服务器

   `ssh-copy-id -p 22 root@ip地址`

2. 登录云服务器，在服务器上给.ssh 文件夹和 authorized_keys 文件授权

   `chmod 600 ~/.ssh/authorized_keys`

   `chmod 700 ~/.ssh`

## 3.Vscode 配置

在 vscode 上安装插件`Remote - SSH`,按下`F1`找到`Remote-SSH`的 configure 文件进行以下配置

```vim
Host IP地址
   HostName ip地址
   Port 22
   User root
   IdentityFile ~/.ssh/id_rsa
```
