# README

## 文档编辑

1. 推荐编辑器 Vscode + git + markdownlint（md语句规范，必装） + markdown all in one, vscode的设置文件已经配好
2. 每次 push 前必须先 git fetch 拉取上游最新的代码,合并之后再进行 push 操作
3. 文档中的图片全部放在Pictures文件夹下，驼峰命名，保证原图的清晰
4. 关于各种笔记文件放在Notes文件夹下

## 协同开发

1. 初始化git仓库
`git clone #你自己fork完后的git地址`
2. 添加该项目为上游项目
`git remote add upstream https://github.com/wswdavid/Study_Record.git`
3. 本地编写文档，完成该次的文档编辑，需要合并代码到主库

    `git fetch upstream`拉取设置的上游主库代码

    `git merge upstream/master` 跟主库代码进行合并

4. 解决本地冲突后提交commit
5. `git push origin master` push 代码至主库

一些典型的git流程操作可以参考[Git FLow](./Notes/DevOps/GitFlow.md)
，持续更新中。
