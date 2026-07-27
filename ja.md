# Rust Skills

[English](README.md) | [日本語](ja.md)

Rust Skillsは、Rust向けのCodex skillを保守・公開するrepositoryです。実装するskillは[`skills/`](skills/)に置き、repository全体の利用方法と保守手順はこのREADMEとGitHub Actionsに集約します。

## 収録skill

### `write-idiomatic-rust`

Rustコードの実装、修正、レビュー、リファクタリングで、公開APIと内部実装を同じ品質基準で扱うskillです。Rust API Guidelines、Microsoft Pragmatic Rust Guidelines、Rust Design Patternsから変更に該当する規則を参照し、命名、関数とmethodの配置、型・所有権・error設計、可読性、予測可能性を確認します。strict Clippy runnerはproject固有のClippyを置き換えず、追加のreview基準として実行します。

Crate guideは依存の固定推奨listではなく、標準library、既存依存、小さな手書き実装と比較するための候補を示します。`garde`はrequest、form、config等の複数field・nested・条件付きvalidationの候補です。候補crateを採用するときは、実装前にregistryの最新releaseと選定versionの公式documentationを確認し、API、feature、MSRV、互換性をprojectの要件と照合します。

## セットアップ

```bash
npx skills add azishio/rust-skills --skill write-idiomatic-rust
```

`skills` CLIは`skills/`配下のskillを検出し、必要なreferenceを含む追跡済みsupport fileをすべてinstallします。全projectで利用する場合は`--global`、特定agentを指定する場合は`--agent <agent>`、symlinkを使えない場合は`--copy`を指定します。

## Maintainer向けセットアップ

repositoryを通常どおりcloneしてください。追跡済みreferenceはそのままlocal validationに使用でき、`skills add`によるinstallにも含まれます。

## 参照資料の更新

GitHub Actionsは毎週月曜日にRust API Guidelines、Microsoft Pragmatic Rust Guidelines、Rust Design Patternsから必要な`src/` directoryとlicense textをvendorします。差分がある場合は、正確なsource commitを[`reference-sources.json`](reference-sources.json)へ記録して自動commit・pushします。必要に応じてActionsの`workflow_dispatch`で手動実行してください。

## 構成

- `skills/`: 配布するagent向けskill。各skillには実行指示、agentが参照する資料、補助scriptだけを置く。
- `.github/workflows/update-references.yml`: 毎週実行するreference更新自動化。
- `README.md` と `ja.md`: 英語版・日本語版の人間向け導入・保守情報。

## License

このrepositoryで作成したfileは、[MIT License](LICENSE-MIT) または [Apache License, Version 2.0](LICENSE-APACHE) のいずれかを、利用者の選択で適用できるdual licenseとします。contributionも、明示的に別条件を指定しない限り同じ条件で受け入れます。

`skills/write-idiomatic-rust/references/` 配下のvendor済みreferenceは独立したupstream projectであり、上記licenseの対象外です。配布時は[Third-party notices](THIRD_PARTY_NOTICES.md)と各referenceに保持したlicense textを確認してください。

## Upstream references

- `rust-lang/api-guidelines` (`master`): Rust API Guidelines。Apache-2.0 または MIT。
- `microsoft/rust-guidelines` (`main`): Pragmatic Rust Guidelines。MIT。
- `rust-unofficial/patterns` (`main`): Rust Design Patterns。MPL-2.0。

それぞれのvendor済みrevision、source、license、含めるpathは[`reference-sources.json`](reference-sources.json)に記録します。
