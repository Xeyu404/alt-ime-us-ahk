# US-AltIME for AutoHotkey v2

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
- [AutoHotkey v2.0 以降](https://www.autohotkey.com/)
- US 配列キーボードを推奨
- Windows の IME（Microsoft IME など）

AutoHotkey v1 では動作しません。

## インストール

1. [US-AltIMEv3.ahk](./US-AltIMEv3.ahk) をダウンロードします。
2. AutoHotkey v2 をインストールします。
3. `US-AltIMEv3.ahk` をダブルクリックして実行します。
4. タスクトレイに AutoHotkey のアイコンが表示されれば起動完了です。

## Windows 起動時に自動実行する

1. `Win + R` を押します。
2. `shell:startup` と入力して Enter を押します。
3. 開いたフォルダーに `US-AltIMEv3.ahk` のショートカットを配置します。

スクリプトを更新した場合は、実行中のスクリプトを再起動してください。`#SingleInstance Force` により、新しいインスタンスを起動すると古いインスタンスが置き換えられます。

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

## コントリビューション

不具合報告や改善提案は Issue へ、コード変更は Pull Request へお願いします。詳しくは [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## クレジット

このプロジェクトは、以下のプロジェクトを参考にしています。

- [kskmori/US-AltIME.ahk](https://github.com/kskmori/US-AltIME.ahk)
- [karakaram/alt-ime-ahk](https://github.com/karakaram/alt-ime-ahk)

## ライセンスと再配布

現時点では、このリポジトリにオープンソースライセンスは付与していません。参照元を含む権利関係については [NOTICE.md](./NOTICE.md) を確認してください。
