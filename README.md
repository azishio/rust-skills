# Rust Skills

Rust向けのCodex skillを保守・公開するrepositoryです。実装するskillは[`skills/`](skills/)に置き、repository全体の利用方法と保守手順はこのREADMEと[`justfile`](justfile)に集約します。

## 収録skill

### `write-idiomatic-rust`

Rustコードの実装、修正、レビュー、リファクタリングで、公開APIと内部実装を同じ品質基準で扱うskillです。Rust API Guidelines、Microsoft Pragmatic Rust Guidelines、Rust Design Patternsから変更に該当する規則を参照し、命名、関数とmethodの配置、型・所有権・error設計、可読性、予測可能性を確認します。strict Clippy runnerはproject固有のClippyを置き換えず、追加のreview基準として実行します。

Crate guideは依存の固定推奨listではなく、標準library、既存依存、小さな手書き実装と比較するための候補を示します。`garde`はrequest、form、config等の複数field・nested・条件付きvalidationの候補です。候補crateを採用するときは、実装前にregistryの最新releaseと選定versionの公式documentationを確認し、API、feature、MSRV、互換性をprojectの要件と照合します。

## セットアップ

```bash
git clone --recurse-submodules <repository-url>
cd rust-skills
just setup
```

`just setup`はsubmoduleを親repositoryで記録されたrevisionへ初期化し、各upstreamで必要な`src/`だけをsparse checkoutします。これらのsubmoduleはskillの実行に必要なreferenceであり、配布・インストール時には必ず初期化済みにします。agentはJustfileを実行しません。

## 参照資料の更新

`just update-references`はRust API Guidelines、Microsoft Pragmatic Rust Guidelines、Rust Design Patternsの追跡ブランチ先端へsubmoduleを更新します。この操作で親repositoryのgitlinkが変更されるため、内容を確認してから親repositoryへcommitしてください。通常の`just setup`は記録済みrevisionへ戻すため、再現可能なskill利用環境を提供します。

## 構成

- `skills/`: 配布するagent向けskill。各skillには実行指示、agentが参照する資料、補助scriptだけを置く。
- `justfile`: clone後の初期化、参照資料の更新、sparse checkout設定。
- `README.md`: 人間向けの導入・保守情報。

## License

このrepositoryで作成したfileは、[MIT License](LICENSE-MIT) または [Apache License, Version 2.0](LICENSE-APACHE) のいずれかを、利用者の選択で適用できるdual licenseとする。contributionも、明示的に別条件を指定しない限り同じ条件で受け入れる。

`skills/write-idiomatic-rust/references/` 配下のsubmoduleは独立したupstream projectであり、上記licenseの対象外である。各submoduleのライセンスと配布時の注意は[Third-party notices](THIRD_PARTY_NOTICES.md)を確認する。referenceを含むarchiveやpackageを配布するときは、submoduleを初期化し、含まれるupstreamのlicense textとnoticeを保持する。

## Upstream references

- `rust-lang/api-guidelines` (`master`): Rust API Guidelines。Apache-2.0 または MIT。
- `microsoft/rust-guidelines` (`main`): Pragmatic Rust Guidelines。MIT。
- `rust-unofficial/patterns` (`main`): Rust Design Patterns。MPL-2.0。

それぞれの固定revisionは親repositoryのgitlinkに記録されます。source、revision、licenseの保守情報はこのREADME、`.gitmodules`、[Third-party notices](THIRD_PARTY_NOTICES.md)で管理し、skill本体には含めません。
