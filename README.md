# Claude Code on Dev Container テンプレート

by [株式会社ヨキミライ](https://yokimirai.com)

Claude Code を Dev Container 上ですぐに使い始めるためのテンプレートリポジトリです。
Windows、macOS、Linux、さらにはブラウザ上の GitHub Codespaces — どの環境でも同じ開発体験が得られます。

株式会社ヨキミライでは、このテンプレートを社内の開発環境の標準として使用しています。

## 含まれるもの

| ツール | バージョン | 説明 |
|--------|-----------|------|
| Debian | 12 (bookworm) | ベース OS |
| Node.js | LTS（Dockerfile で指定） | JavaScript ランタイム |
| Claude Code | 最新 | AI コーディングアシスタント CLI |
| Git | 最新 | バージョン管理 |
| GitHub CLI | 最新 | GitHub 操作用 CLI |
| VS Code 拡張 | — | Claude Code, Prettier, GitHub Actions, GitHub PR |

## 使い方

### GitHub Codespaces で使う

1. このテンプレートから新しいリポジトリを作成（「Use this template」ボタン）
2. 作成したリポジトリで「Code」→「Codespaces」→「Create codespace on main」
3. コンテナが起動したらターミナルで `claude` を実行

### ローカル Dev Container で使う

1. [Docker](https://www.docker.com/) と [VS Code](https://code.visualstudio.com/) をインストール
2. VS Code に [Dev Containers 拡張](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) をインストール
3. このテンプレートから新しいリポジトリを作成してクローン
4. VS Code でフォルダを開き「Reopen in Container」を選択
5. コンテナが起動したらターミナルで `claude` を実行

## カスタマイズガイド

テンプレートをプロジェクトに合わせてカスタマイズする手順です。優先度順に記載しています。

### 1. `CLAUDE.md`（最初にここから）

Claude Code がプロジェクトを理解するためのコンテキストファイルです。
パート1（動作原則）はそのまま使えます。パート2（プロジェクト情報）の HTML コメントを参考に、プロジェクト固有の情報を記述してください。

### 2. `skills-lock.json`（Claude Code スキル管理）

Claude Code のスキルを一括管理するファイルです。
コンテナ作成時に `npx skills experimental_install` で自動復元されます。

スキルの追加は以下のコマンドで行います（`skills-lock.json` が自動更新されます）：

```bash
npx -y skills add https://github.com/trailofbits/skills --skill devcontainer-setup -y
```

### 3. `.devcontainer/Dockerfile`

開発環境に必要なツールを追加します。
`devcontainer.json` の `features` でツールを追加するのが簡単です。
Dockerfile に直接記述する場合は、カスタマイズセクション（root ユーザー区間）に追加してください。

### 4. `.devcontainer/devcontainer.json`

VS Code の拡張機能や設定を変更します：

- `extensions` — プロジェクトで使う拡張機能を追加
- `forwardPorts` — 開発サーバーのポートを指定
- `containerEnv` — 環境変数を設定

### 5. `.devcontainer/setup.sh`

コンテナ作成後に自動実行されるスクリプトです。
ファイル末尾の「カスタマイズ」セクションにプロジェクト固有のセットアップコマンドを追加してください。

### 6. `.gitignore`

Node.js の標準的なパターンが設定済みです。
末尾の「プロジェクト固有の除外パターン」セクションに必要なパターンを追加してください。

## 永続ボリュームの仕組み

以下の設定が Docker ボリュームに保存され、コンテナを再作成しても維持されます。

| ボリューム名 | 内容 |
|-------------|------|
| `claude-config` | Claude Code の認証情報・セッション履歴 |
| `claude-cli-history` | シェルのコマンド履歴 |
| `claude-gh-config` | GitHub CLI の認証情報 |

```jsonc
// devcontainer.json の該当箇所
"mounts": [
  "source=claude-config,target=/home/vscode/.claude,type=volume",
  "source=claude-cli-history,target=/home/vscode/.bash_history_dir,type=volume",
  "source=claude-gh-config,target=/home/vscode/.config/gh,type=volume"
]
```

設定をリセットしたい場合は、Docker ボリュームを削除してください：

```bash
docker volume rm claude-config
```

## プロジェクト構成

```
.
├── .devcontainer/
│   ├── Dockerfile          # コンテナイメージ定義
│   ├── devcontainer.json   # Dev Container 設定
│   └── setup.sh            # 初回セットアップスクリプト
├── .gitignore              # Git 除外パターン
├── CLAUDE.md               # Claude Code コンテキスト
├── skills-lock.json        # Claude Code スキル管理
└── README.md               # このファイル
```

## ご利用上の注意

- このテンプレートの利用には [Claude Code](https://claude.ai/) のアカウントが必要です（Anthropic の利用規約に従ってください）
- テンプレートは現状のまま（AS IS）提供されます。動作保証やサポートの義務はありません
- `claude-config` ボリュームには Claude の認証情報が含まれます。Docker ボリュームの共有やエクスポートにはご注意ください
- セキュリティに関わるファイル（`.env`、API キーなど）をリポジトリにコミットしないよう注意してください

## ライセンス

MIT License - 詳細は [LICENSE](LICENSE) ファイルを参照してください。

Copyright (c) 2025 株式会社ヨキミライ
