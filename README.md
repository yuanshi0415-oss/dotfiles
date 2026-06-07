# 🐉 dotfiles · 坤哥开发环境

一行命令装好开发环境。

```bash
bash install.sh
```

## 装了什么

| 类别 | 内容 |
|------|------|
| **shell别名** | l/.. /gs/gc/gp/gl/ports/mem/disk |
| **代理** | proxy-on/proxy-off + 自动检测sing-box |
| **Git** | 默认分支main + alias (co/br/st/lg) |
| **vim** | 行号/颜色主题/缩进2空格/剪贴板 |
| **工具** | curl/git/htop/fzf/ripgrep（缺的自动装） |

## 自动检测

- 如果7890端口开放（sing-box/mihomo），自动设代理
- 检测 apt 或 brew 自动安装缺失工具
- 检测是否已有坤哥配置，不重复追加

## License MIT
