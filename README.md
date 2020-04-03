# README

## 运行

- 安装 gitbook

  `npm install gitbook-cli -g`

- clone 代码至本地运行

  ```shell
  git clone https://github.com/wswdavid/Study_Record.git
  cd Study_Record
  gitbook install
  gitbook serve
  ```

## 文档编辑

1. 编写前请在命令行输入 `npm install` 进行包初始化
2. 推荐编辑器 `Vscode + git + markdownlint（md 语句规范，必装） + markdown all in one`, vscode 的设置文件已经配好
3. 开启了 `markdownlint` 检查，commit 前进行验证
4. 每次 push 前必须先 `git fetch` 拉取上游最新的代码,合并之后再进行 push 操作
5. 文档中的图片全部放在 `Pictures` 文件夹下，驼峰命名，保证原图的清晰
6. 关于各种笔记文件放在 `Notes` 文件夹下

## 协同开发

1. 初始化 git 仓库
   `git clone #你自己fork完后的git地址`
2. 添加该项目为上游项目
   `git remote add upstream https://github.com/wswdavid/Study_Record.git`
3. 本地编写文档，完成该次的文档编辑，需要合并代码到主库

   `git fetch upstream`拉取设置的上游主库代码

   `git merge upstream/master` 跟主库代码进行合并

4. 解决本地冲突后提交 commit
5. `git push origin master` push 代码至主库

一些典型的 git 流程操作可以参考[Git FLow](./Notes/DevOps/GitFlow.md)，持续更新中。
