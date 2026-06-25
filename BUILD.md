# Build

## Requirements

- Windows
- AutoHotkey v2.0.19 or later
- Ahk2Exe

AutoHotkey を通常のインストーラーで導入すると、Ahk2Exe は通常
`C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe` に配置されます。

## Build the 64-bit executable

PowerShell でリポジトリのルートから次を実行します。

```powershell
New-Item -ItemType Directory -Force dist | Out-Null

& "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" `
  /in ".\US-AltIMEv3.ahk" `
  /out ".\dist\US-AltIME-v3.0.0-x64.exe" `
  /base "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" `
  /silent verbose
```

環境によっては `/base` を次のようなバージョン別パスへ変更してください。

```text
C:\Program Files\AutoHotkey\v2.0.19\AutoHotkey64.exe
```

## Verify

出力ファイルとバージョン情報を確認します。

```powershell
Get-Item ".\dist\US-AltIME-v3.0.0-x64.exe" |
  Select-Object FullName, Length, VersionInfo

Get-FileHash ".\dist\US-AltIME-v3.0.0-x64.exe" -Algorithm SHA256
```

## Release automation

`v` で始まるタグをpushすると、`.github/workflows/release.yml` が以下を実行します。

- AutoHotkey v2 64-bit版でコンパイル
- `.exe`、`.ahk`、配布用ZIPを生成
- SHA-256チェックサムを生成
- GitHub Releaseを作成して成果物を添付

例:

```powershell
git tag -a v3.0.0 -m "US-AltIME v3.0.0"
git push origin v3.0.0
```

## Code signing

現在の配布EXEにはコード署名を行いません。そのため、Windows SmartScreenが警告を表示する場合があります。
コード署名証明書を導入する場合は、Releaseへアップロードする前に `signtool.exe` で署名してください。
