# Nginx

1. 添加源

    Nginx 不在默认的 yum 源中，可以使用 epel 或者官网的 yum 源，以下可以二选一。

    ```bash
    #官网yum源
    sudo rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

    #EPEL源
    sudo yum install epel-release
    ```

2. 安装Nginx

    ```bash
    sudo yum install nginx -y
    ```

3. 开启反向代理
   本来想代理gitbook的端口到默认端口的，发现总是打不开。后来研究一下由于CentOS 7 的 SELinux，使用反向代理需要打开网络访问权限。

   ```bash
   sudo setsebool -P httpd_can_network_connect on
   ```
