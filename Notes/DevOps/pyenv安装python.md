## 依赖准备

`sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel -y`

## 安装 pyenv

`curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash`

## 使用

`pyenv versions`
查看当前 pyenv 可检测到的所有版本，处于激活状态的版本前以 \* 标示。

`pyenv version`
查看当前处于激活状态的版本，括号中内容表示这个版本是由哪条途径激活的（global、local、shell）

`pyenv install`
使用 python-build（一个插件） 安装一个 Python 版本，到 \$PYENV_ROOT/versions 路径下。

`pyenv install -v 3.6.5`
建议添加 -v 参数用于显示细节。python-build 会首先尝试从一个镜像站点下载包，此时可以去 /tmp/python-build.xxx 里面关心一下下载速度。如果太慢，可以直接在 shell 里 ctrl-c 终止此次下载，然后 python-build 会自动去 python.org/ftp 下载。不一定哪个更快。

`pyenv global 3.6.5`
设置全局的 Python 版本，通过将版本号写入 ~/.pyenv/version 文件的方式。
