# gacp
![test](https://github.com/kageyama-sha3/gacp/actions/workflows/test.yml/badge.svg)

標準入力から受け取ったファイルを、`git add` → `git commit` → `git push` まで一度に行うコマンドです。

## 使い方
```
$ echo README.md | ./gacp "READMEを修正"
a1b2c3d READMEを修正
```
パイプで、コミットしたいファイルを選べます。
```
$ git diff --name-only | ./gacp "変更したファイルをまとめてコミット"
$ ls *.py | ./gacp "Pythonファイルを更新"
```

## 入出力
- コミットメッセージ（必須）
- 標準入力：コミットするファイル名（1行に1つ、空行は無視）
- 標準出力：作成したコミットの短いハッシュとメッセージ
- 次の場合は標準エラー出力にメッセージを出し、終了ステータス1で終了します
  - メッセージがない
  - 存在しないファイルがある
  - 入力が空
  - 変更がなくコミットできない
  - pushに失敗した

## インストール
```
$ git clone https://github.com/kageyama-sha3/gacp.git
$ cd gacp
```
どこからでも使いたい場合は、`gacp`をPATHの通ったディレクトリ（例：`~/bin`）にコピーしてください。

## 必要なソフトウェア
- bash
- git（pushするには、上流ブランチを設定してあること）

## テスト環境
- Ubuntu（GitHub Actions の ubuntu-latest）

## ライセンス・著作権
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- テストスクリプトの形式は、講義「ロボットシステム学」の資料（CC BY-SA 4.0）を参考にしています。
- © 2026 蔭山　陽雲
