# README

## Install and Run

- 安装 gitbook

  `npm install gitbook-cli -g`

- clone 代码至本地运行

  ```shell
  git clone https://github.com/wswdavid/Study_Record.git
  cd Study_Record
  #npm install
  #如果需要commit前进行markdownlint则执行这一条
  gitbook install
  gitbook serve
  ```

## 注意事项

1. 编写前请在命令行输入 `npm install` 进行包初始化，会在 commit 前执行 `markdownlint` 进行 md 文件规范的验证
2. 推荐编辑器 `vscode + git + markdownlint + markdown all in one`, vscode 的设置文件已经配置好
3. 文档中的图片全部放在 `Pictures` 文件夹下，驼峰命名
4. 关于各种笔记文件放在 `Notes` 文件夹下

## 协同开发

1. 初始化 git 仓库

   `git clone #你自己fork完后的git地址`

2. 添加该项目为上游项目

   ```shell
   git remote add upstream https://github.com/wswdavid/Study_Record.git
   git remote -v
   #此时可以看到分别有origin 和 upstream 两个远程仓库
   ```

3. 本地编写文档，完成本次的文档编辑，需要跟上游主库主库代码进行合并

   `git fetch upstream`拉取上游主库代码

   `git merge upstream/master` 跟上游主库代码进行合并

4. 解决与上游主库文件冲突后提交本次的 commit
5. push 代码至个人仓库

   `git push origin master`

6. 发起 `Pull Request` 流程

<<<<<<< HEAD
4. 解决本地冲突后提交commit
5. `git push origin master` push 代码至主库

一些典型的git流程操作可以参考[Git FLow](./Notes/DevOps/GitFlow.md)
，持续更新中
=======
> 一些典型的 git 流程操作可以参考[Git 操作流程](./Notes/DevOps/GitFlow.md)，持续更新中。
>>>>>>> upstream/master
