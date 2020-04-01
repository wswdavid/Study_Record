## 1. 安装 zsh

`yum install zsh -y`

切换 shell 为 zsh

`chsh -s /bin/zsh`

## 2. 安装 oh-my-zsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
`source ~/.zshrc`

`vim ~/.zshrc`

把 ZSH_THEME 替换成 agnoster
`source ~/.zshrc`

## 3. 安装插件

zsh-autosuggestions 根据命令历史，提供灰色的候选，按向右键即可选择

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

更好的显示效果，可以执行一次：

`echo "export TERM=xterm-256color" >> ~/.zshrc`

zsh-syntax-highlighting 根据实时的输入，提供一些额外的配色和格式，有些主题下会显得太花

`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

配置插件

`vim ~/.zshrc`

在 plugin 里加上 zsh-autosuggestions 和 zsh-syntax-highlighting，以空格分隔开

`source ~/.zshrc`
