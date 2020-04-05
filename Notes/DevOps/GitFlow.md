# Git Flow

一些比较常用的 Git 操作流程

## 回滚到之前的某一个 commit

```git
git reset --hard COMMIT_ID
```

## 删除 commit

### 删除版本库的前一个提交

```git
git reset --hard HEAD~1
#HEAD~1回到上一次的提交
#加上参数--hard则不保留当前更改,soft则保留当前更改
git push --force
```

### 删除版本库的某一个 commit

```git
git log #查看commit记录
git rebase -i  $commit_id #需要删除的commit的前一次id
#把pick 改成 drop，保存退出，并修改冲突，修改完成
```

### 删除所有历史 commits

1. 创建 orphan 分支 `git checkout --orphan latest_branch`
2. 添加所有文件 `git add -A`
3. 提交更改 `git commit -am "commit message"`
4. 删除分支 `git branch -D master`
5. 将当前分支重命名 `git branch -m master`
6. 最后，强制更新存储库。 `git push -f origin master`

## 合并 commits

### 撤销过去的 commit 重建一个新的 commit

```git
git reset HEAD~$Commits_Num #需要撤销前几次的commit
git add .
git commit -am "message"
git push origin master -f
```

## 通过 git rebase

```git
git rebase -i commit_id #至少前面的两次提交
#此时git会打开编辑器，修改Pick
#squash : 将这一行的 commit 与上一个 commit 进行合并
#fixup : 与 squash 相同，只是不会保留这行 commit 的提交 message 信息
git push origin master -f
```
