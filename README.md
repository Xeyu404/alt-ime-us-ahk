# AltIME for US Layout

![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0%2B-334455?logo=autohotkey)
![Platform](https://img.shields.io/badge/platform-Windows-0078D4?logo=windows)

US 配列キーボードで、左右の Alt キーを使って日本語 IME を明示的に切り替える AutoHotkey v2 スクリプトです。

> Tap Right Alt to turn the IME on. Tap Left Alt to turn the IME off.

## 動作

| 操作 | 結果 |
| --- | --- |
| `右 Alt` を単押し | IME を ON（日本語入力） |
| `左 Alt` を単押し | IME を OFF（英数入力） |
| `Alt + 他のキー` | 通常の Alt ショートカットとして動作 |

## 特徴

- IME の状態をトグルせず、左右の Alt に ON / OFF を固定して割り当て
- `A_PriorHotkey` と `A_PriorKey` を使った厳密な単押し判定
- 曖昧な入力状態では切り替えないことで、Alt ショートカット時の誤作動を抑制
- 64 bit Windows に対応したポインタサイズの Windows API 呼び出し
- フォーカス中のコントロールを考慮した IME ウィンドウ取得
- `#SingleInstance Force` による二重起動の防止

## 必要環境

- Windows 10 または Windows 11
- US 配列キーボードを推奨
- Windows の IME（Microsoft IME など）
- ソース版を実行する場合のみ [AutoHotkey v2.0 以降](https://www.autohotkey.com/)

EXE版では AutoHotkey 本体のインストールは不要です。ソース版は AutoHotkey v1 では動作しません。

## ダウンロード

### EXE版（推奨）

1. [Releases](https://github.com/Xeyu404/alt-ime-us-ahk/releases/latest) を開きます。
2. `AltIME-US-v*-x64.exe` または配布用ZIPをダウンロードします。
3. EXEを任意のフォルダーへ置き、ダブルクリックして実行します。

AutoHotkey本体のインストールは不要です。

配布EXEにはコード署名を行っていないため、Windows SmartScreenが警告を表示する場合があります。
不安な場合は `SHA256SUMS.txt` でファイルを確認するか、ソース版を利用してください。

### ソース版

1. [AltIME-US.ahk](./AltIME-US.ahk) をダウンロードします。
2. AutoHotkey v2 をインストールします。
3. `AltIME-US.ahk` をダブルクリックして実行します。
4. タスクトレイに AutoHotkey のアイコンが表示されれば起動完了です。

## ダウンロードの検証

Releaseに添付された `SHA256SUMS.txt` と、ダウンロードしたファイルのSHA-256を比較できます。

```powershell
Get-FileHash ".\AltIME-US-v3.0.1-x64.exe" -Algorithm SHA256
```

## Windows 起動時に自動実行する

1. `Win + R` を押します。
2. `shell:startup` と入力して Enter を押します。
3. 開いたフォルダーに、利用するファイルへのショートカットを配置します。
   - EXE版: `AltIME-US-v*-x64.exe`（例: `AltIME-US-v3.0.1-x64.exe`）
   - ソース版: `AltIME-US.ahk`

EXE版はReleaseごとにファイル名へバージョンが入ります。ショートカット名は `AltIME-US` などに変更して構いませんが、リンク先は実際に配置したEXEを指定してください。ZIP版を使う場合は、ZIPを展開した先のEXEへのショートカットを配置します。

ファイルを更新した場合は、実行中の AltIME for US Layout を再起動してください。`#SingleInstance Force` により、新しいインスタンスを起動すると古いインスタンスが置き換えられます。

## トラブルシューティング

### 管理者権限のアプリで動作しない

通常権限で動作する AutoHotkey スクリプトは、管理者権限で起動したアプリを操作できないことがあります。必要な場合はスクリプトも管理者として実行してください。

### Alt ショートカットと競合する

他の AutoHotkey スクリプト、キーボードリマップツール、ランチャーなどが Alt キーをフックしている場合、動作が競合する可能性があります。競合するツールを一時停止して切り分けてください。

### 右 Alt が AltGr として動作する

US 配列以外のキーボードレイアウトでは、右 Alt が AltGr として扱われることがあります。このスクリプトは US 配列を前提としています。

### Alt を単押ししても切り替わらない

誤作動防止のため、直前の物理キーを明確に確認できない場合は IME を切り替えません。他の入力フック系ソフトウェアを停止して確認してください。

## 実装について

IME の取得と設定には `ImmGetDefaultIMEWnd` と `WM_IME_CONTROL` を使用しています。対象ウィンドウのフォーカス先は `GetGUIThreadInfo` から取得し、HWND やポインタは `Ptr` 型で扱っています。

## 変更履歴

詳細は [CHANGELOG.md](./CHANGELOG.md) を参照してください。

## ビルド

ローカルでのコンパイル方法とRelease自動化については [BUILD.md](./BUILD.md) を参照してください。

## コントリビューション

不具合報告や改善提案は Issue へ、コード変更は Pull Request へお願いします。詳しくは [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## プロジェクトの系譜とクレジット

このスクリプトは [kskmori/US-AltIME.ahk](https://github.com/kskmori/US-AltIME.ahk) の Alt / IME 制御部分を直接のベースとして、用途を US 配列向けの左右 Alt による IME 制御へ絞り、AutoHotkey v2・64 bit 環境向けに再構成した派生版です。

kskmori 版は、[karakaram/alt-ime-ahk](https://github.com/karakaram/alt-ime-ahk) が確立した「左右 Alt の空打ちで IME を明示的に OFF / ON にする」設計と機能を継承・拡張しています。本プロジェクトも、その設計上の系譜を引き継いでいます。

両プロジェクトの作者と貢献者に感謝します。

## ライセンスと再配布

現時点では、このリポジトリにオープンソースライセンスは付与していません。派生元を含む権利関係については [NOTICE.md](./NOTICE.md) を確認してください。
