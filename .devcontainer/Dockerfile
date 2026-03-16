# ==================================================
# ベースイメージ（Debian 12 + 基本ツール）
# ==================================================
FROM mcr.microsoft.com/devcontainers/base:debian-12

# パイプ中のエラーを検知する（curl | bash の失敗を見逃さない）
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ==================================================
# システムパッケージ
# ==================================================
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       bubblewrap \
       python3 \
       socat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ==================================================
# Node.js（Claude Code の動作に必要 / Node.js 18 以上）
# バージョンを変更するには下の数値を書き換えてください（例: 20, 22, 24）
# ==================================================
ARG NODE_MAJOR=22
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ==================================================
# カスタマイズ: ここにプロジェクト固有のツールを追加
# （この時点では root ユーザーなので apt-get 等がそのまま使えます）
#
# ツールの追加は devcontainer.json の "features" を使うのが簡単です
# https://containers.dev/features
# ==================================================

# ==================================================
# Claude Code CLI（末尾に配置 — これより下は vscode ユーザー）
# ==================================================
USER vscode
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/home/vscode/.local/bin:${PATH}"
