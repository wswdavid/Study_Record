<!-- toc -->

# Gitbook 的项目结构

## book.json

```json
{
  "title": "Study Record",
  "description": "David WU 的个人记录",
  "author": "wswdavid",
  "language": "en",
  "gitbook": "3.2.3",
  "root": ".",
  "structure": {
    "readme": "README.md"
  },
  "plugins": [
    "-lunr",
    "-search",
    "-highlight",
    "-livereload",
    "-sharing",
    "search-plus",
    "simple-page-toc",
    "github",
    "edit-link",
    "theme-comscore",
    "prism",
    "prism-themes",
    "advanced-emoji",
    "anchors",
    "include-codeblock",
    "ace",
    "emphasize",
    "katex",
    "splitter",
    "tbfed-pagefooter",
    "expandable-chapters-small",
    "sectionx",
    "local-video",
    "sharing-plus",
    "github-buttons",
    "todo",
    "copy-code-button"
  ],

  "pluginsConfig": {
    "github": {
      "url": "https://github.com/wswdavid/Study_Record"
    },
    "edit-link": {
      "base": "https://github.com/wswdavid/Study_Record/blob/master",
      "label": "Edit This Page"
    },
    "sectionx": {
      "tag": "b"
    },
    "fontsetting": { "size": 12 },
    "simple-page-toc": {
      "maxDepth": 3,
      "skipFirstH1": true
    },
    "github-buttons": {
      "buttons": [
        {
          "count": false,
          "width": "135",
          "type": "follow",
          "user": "wswdavid",
          "size": "small"
        }
      ]
    },
    "prism": {
      "css": ["prism-themes/themes/prism-atom-dark.css"]
    },
    "include-codeblock": {
      "template": "ace",
      "unindent": true,
      "edit": true
    },
    "tbfed-pagefooter": {
      "copyright": "<a href='http://www.beian.miit.gov.cn'>粤 ICP 备 19162056-1 号</a> Copyright © wswdavid 2020",
      "modify_label": "该文件修订时间：",
      "modify_format": "YYYY-MM-DD HH:mm:ss"
    },
    "sharing": {
      "weibo": true,
      "qq": true,
      "vk": false,
      "facebook": true,
      "all": ["facebook", "google", "twitter", "weibo", "instapaper"]
    }
  }
}
```
