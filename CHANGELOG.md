# Changelog

このプロジェクトの主な変更内容を記録します。

## [Unreleased]

現在、未リリースの変更はありません。

## [3.0.0] - 2026-06-25

### Added

- `#SingleInstance Force` を追加し、スクリプトの二重起動を防止
- Alt キー処理を `AltIME_Down` / `AltIME_Up` に共通化
- IME 制御処理を `IME_SendControl` / `IME_GetTargetHwnd` に分離
- `README.md` などのリポジトリドキュメントを追加

### Changed

- 右 Alt 単押しで IME ON、左 Alt 単押しで IME OFF という既存仕様を維持しつつ、単押し判定を厳密化
- `A_PriorHotkey` と `A_PriorKey` の両方を確認するよう変更
- `A_PriorKey == ""` の曖昧な状態では IME を切り替えないよう変更
- Alt ホットキーに `$` プレフィックスを追加し、スクリプト自身の `Send` による再発火を防止
- HWND、Buffer ポインタ、Windows API の戻り値を `Ptr` 型で扱うよう変更
- `WinActive` と `GetGUIThreadInfo` を利用して、対象ウィンドウとフォーカス先を安全に取得

### Fixed

- 64 bit 環境でポインタやウィンドウハンドルが `UInt` に切り詰められる可能性を修正
- `WinGetID` が関数として呼び出されていなかった旧実装の脆弱性を解消
- `IMC_GETOPENSTATUS` に対する誤ったコメントを修正
- Alt と他のキーを組み合わせた際に IME 切り替えが誤発火する可能性を低減

## Previous versions

v3 より前のバージョンは、このリポジトリでは正式なリリースとして管理していません。
