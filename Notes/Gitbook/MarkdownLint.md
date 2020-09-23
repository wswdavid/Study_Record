# commit 前 进行 markdownlint 规则检查

为了保证每次提交上来的 md 文件有一定的规范性，最好的办法是在本地提交时就能够扫描出潜在的错误，并强制将其修改后才能提交。这里主要用到以下两个工具。

- **markdownlint** markdown 代码检查，依赖于 `Eslint`，使用前需要在 vscode 里安装 Eslint，不符合规范的会自动进行提示。

- **husky** git 操作的钩子，在进行 commit 时，执行 mardkwonlint 检查所有 md 文件的格式，保证 commit 之后的文件都符合规范。

安装 markdown-cli

`npm install markdownlint-cli`

关于 markdownlint 的规则可以通过自己创建一个 `.markdownlint.yaml` 文件进行自定义。

```json
{
  "default": true,
  "MD013": false,
  "MD029": false,
  "MD036": false,
  "MD033": false,
  "MD041": false,
  "MD045": false
}
```

配置 `package.json` 文件

```json
{
  "name": "StudyRecord",
  "version": "1.0.0",
  "description": "",
  "scripts": {
    "lint-md": "node_modules/.bin/markdownlint  --ignore _book --ignore node_modules **/*.md "
  },
  "husky": {
    "hooks": {
      "pre-commit": "npm install && npm run lint-md"
    }
  },
  "devDependencies": {
    "husky": "^1.3.1"
  },
  "dependencies": {
    "markdownlint-cli": "^0.22.0"
  }
}
```
