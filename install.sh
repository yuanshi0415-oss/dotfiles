#!/bin/bash
# 🐉 坤哥环境一键配置
set -e

echo "🐉 坤哥环境配置中..."

# 别名
cat >> ~/.bashrc << 'EOF'
# 🐉 坤哥配置
alias l='ls -lah'
alias ll='ls -la'
alias ..='cd ..'
alias cat='batcat' 2>/dev/null || true
alias fd='fdfind' 2>/dev/null || true
alias v='nvim' 2>/dev/null || true

# 代理开关
alias proxy-on='export https_proxy=http://127.0.0.1:7890; export http_proxy=http://127.0.0.1:7890; echo "🔓 代理开"'
alias proxy-off='unset https_proxy; unset http_proxy; echo "🔒 代理关"'

# git
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# 快速查看
alias ports='ss -tlnp'
alias mem='free -h'
alias disk='df -h'
alias top='htop' 2>/dev/null || true

# 历史搜索
alias hg='history | grep '
EOF

# 设置默认分支名
git config --global init.defaultBranch main

# 设置代理（如果有）
if [ -f ~/.config/sing-box/config.json ]; then
  cat >> ~/.bashrc << 'EOF'
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
EOF
fi

echo "✅ 坤哥环境配置完成！重开终端或 source ~/.bashrc"
