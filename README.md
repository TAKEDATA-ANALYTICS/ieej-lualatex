# 電気学会全国大会 LaTeX テンプレート

電気学会全国大会の講演論文用LaTeXテンプレートです。

## ファイル構成

- `ieej.cls` - クラスファイル
- `template-j.tex` - テンプレート（日本語）
- `Makefile` - ビルド用
- `latexmkrc` - latexmk設定
- `compile.sh` - コンパイルスクリプト

## 必要パッケージ（Ubuntu/Debian）

```bash
sudo apt-get install texlive-lang-japanese texlive-luatex \
                     texlive-fonts-extra texlive-plain-generic
```

## コンパイル方法

```bash
latexmk template-j        # 推奨
make                      # または
./compile.sh              # または
lualatex template-j.tex   # 直接実行（2回）
```

## 使用方法

```latex
\documentclass{ieej}

\jtitle{日本語タイトル}
\jauthor{著者 花子\presenter，共著 太郎 (○○大学)}
\etitle{English Title}
\eauthor{Hanako Author, Taro Coauthor (University)}

\maketitle
```

## レイアウト仕様

| 項目 | 寸法 |
|------|------|
| 用紙 | A4 |
| 上下マージン | 20mm |
| 左右マージン | 18mm |
| カラム幅 | 82mm |
| カラム間 | 8mm |
