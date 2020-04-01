# Git Flow

## 删除版本库的前一个提交

```git
git reset --hard HEAD~1
#HEAD~1回到上一次的提交
#加上参数--hard则不保留当前更改,soft则保留当前更改
git push --force
```

## 删除所有历史提交记录

1. 创建orphan分支 `git checkout --orphan latest_branch`
2. 添加所有文件 `git add -A`
3. 提交更改 `git commit -am "commit message"`
4. 删除分支 `git branch -D master`
5. 将当前分支重命名 `git branch -m master`
6. 最后，强制更新存储库。 `git push -f origin master`

## 回滚到之前的某一个commit

```git
git reset --hard COMMIT_ID
```
