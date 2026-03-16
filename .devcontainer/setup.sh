#!/bin/bash
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Dev Container をセットアップしています...${NC}"
echo ""

# Claude CLI 設定ディレクトリの権限修正（ボリュームマウント時に必要）
if [ -d "$HOME/.claude" ] && [ ! -w "$HOME/.claude" ]; then
  sudo chown -R "$(id -u):$(id -g)" "$HOME/.claude"
fi

# skills-lock.json からスキルを復元
echo -e "${BLUE}Claude Code スキルをインストールしています...${NC}"
npx -y skills experimental_install 2>/dev/null \
  || echo -e "${YELLOW}スキルのインストールをスキップしました${NC}"
echo ""

# インストール済みツールのバージョン表示
echo -e "${BLUE}インストール済みバージョン:${NC}"
echo "  Node.js:      $(node --version 2>/dev/null || echo 'N/A')"
echo "  npm:          $(npm --version 2>/dev/null || echo 'N/A')"
echo "  Git:          $(git --version 2>/dev/null | sed 's/git version //' || echo 'N/A')"
echo "  GitHub CLI:   $(gh --version 2>/dev/null | head -1 | sed 's/gh version //' || echo 'N/A')"
echo "  Claude Code:  $(claude --version 2>/dev/null || echo 'N/A')"
echo ""

echo -e "${GREEN}セットアップ完了!${NC}"
echo ""
echo -e "${YELLOW}はじめかた:${NC}"
echo "  ターミナルで Claude Code を使う場合:"
echo "    claude                                    # 対話モードで起動"
echo ""
echo "  VS Code 拡張機能を使う場合:"
echo "    サイドバーの Claude Code アイコンをクリック"
echo ""

# ==================================================
# カスタマイズ: プロジェクト固有のセットアップ
# 必要に応じてここにコマンドを追加してください
# ==================================================
# 例:
# cp .env.example .env
# npx prisma generate
# npx prisma db push
