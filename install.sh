#!/bin/bash
# 🐉 坤哥环境一键配置 v2
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${GREEN}  ✓${NC} $1"; }
warn() { echo -e "${YELLOW}  ⚠${NC} $1"; }
err()  { echo -e "${RED}  ✗${NC} $1"; }

echo ""
echo "  🐉  坤哥环境配置 v2"
echo "  ─────────────────────"
echo ""

# ── 系统检测 ──
OS="$(uname -s)"
ARCH="$(uname -m)"
echo "  系统: $OS $ARCH"

# ── 安装依赖工具 ──
install_if_missing() {
  if ! command -v "$1" &>/dev/null; then
    if command -v apt &>/dev/null; then
      sudo apt install -y "$1" &>/dev/null && info "安装 $1"
    elif command -v brew &>/dev/null; then
      brew install "$1" &>/dev/null && info "安装 $1"
    else
      warn "没找到包管理器，跳过 $1"
    fi
  else
    info "$1 已安装"
  fi
}

echo ""
echo "  📦 工具检查"
echo "  ──"

# 核心工具
for cmd in curl git htop fzf ripgrep; do
  install_if_missing "$cmd"
done

# 可选工具（优雅降级）
for cmd in bat batcat nvim neovim; do
  command -v "$cmd" &>/dev/null && info "$cmd 可用" || true
done

# ── 写入配置 ──
echo ""
echo "  🔧 配置写入"
echo "  ──"

BASHRC_PART=$(cat << 'BASHEOF'

# ── 🐉 坤哥配置 ──────────────────────
alias l='ls -lah'
alias ll='ls -la'
alias ..='cd ..'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias ports='ss -tlnp'
alias mem='free -h'
alias disk='df -h'
alias hg='history | grep '

# 代理开关
alias proxy-on='export https_proxy=http://127.0.0.1:7890; export http_proxy=http://127.0.0.1:7890; echo "🔓 代理开"'
alias proxy-off='unset https_proxy; unset http_proxy; echo "🔒 代理关"'

# 自动走代理（如果端口开放）
if ss -tlnp 2>/dev/null | grep -q :7890; then
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
fi
# ─────────────────────────────
BASHEOF
)

if grep -q "坤哥配置" ~/.bashrc 2>/dev/null; then
  warn "坤哥配置已在 .bashrc 中（跳过，不重复追加）"
else
  echo "$BASHRC_PART" >> ~/.bashrc
  info ".bashrc 已追加坤哥配置"
fi

# ── Git配置 ──
git config --global init.defaultBranch main 2>/dev/null
git config --global alias.co checkout 2>/dev/null
git config --global alias.br branch 2>/dev/null
git config --global alias.st status 2>/dev/null
git config --global alias.lg "log --oneline --graph --decorate" 2>/dev/null
info "Git 配置完成"

# ── vim配置 ──
VIMRC="~/.vimrc"
if [ ! -f ~/.vimrc ]; then
  cat > ~/.vimrc << 'VIMEOF'
" 🐉 坤哥vim配置
syntax on
set number
set tabstop=2 shiftwidth=2 expandtab
set mouse=a
set background=dark
set ignorecase smartcase
set clipboard=unnamedplus
VIMEOF
  info ".vimrc 创建"
fi

# ── 完成 ──
echo ""
echo "  ✅ 坤哥环境配置完成！"
echo ""
echo "  使生效: source ~/.bashrc"
echo "  跳过:   bash install.sh --skip-tools"
echo "  代理开: proxy-on"
echo "  代理关: proxy-off"
