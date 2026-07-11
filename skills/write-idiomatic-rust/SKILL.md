---
name: write-idiomatic-rust
description: 公開APIと内部実装の両方で、可読性が高く慣用的で保守しやすいRustコードを実装、修正、レビュー、リファクタリングする。型・所有権・error設計、関数とmethodの配置、依存追加、Rustのdesign pattern、Clippy指摘を扱うときに使用する。
---

# Write Idiomatic Rust

変更するすべてのcodeを、公開範囲にかかわらず可読性、予測可能性、型安全性、保守性の同じ基準で扱う。既存のconventionと要件を優先し、API Guidelinesとdesign patternsから該当する規則を積極的に探して適用する。規則の目的とtrade-offを考慮し、対象外と判断した規則は理由を説明できるようにする。抽象化や依存は、所有権、型安全性、責務、重複削減に具体的な利益がある場合だけ追加する。

## Workflow

1. `Cargo.toml`、workspace、公開範囲、edition、`rust-version`、feature、`no_std`、既存依存、関連testを確認する。
2. public/privateを問わず、変更するAPI、型、所有権、error、関数とmethodの配置、構築処理を特定し、既存の名前とconventionを優先する。
3. 下の「Reference guide」から、変更するcodeに該当するchecklist項目とfileを積極的に選んで読む。公開API専用の規則を除き、内部実装にも同じ設計基準を適用する。patternは利点と欠点を併読する。
4. 読み手が責務、data flow、所有権を追いやすい最小案を選び、既存動作と公開互換性を保って実装する。短さや再利用の可能性だけを理由にhelper、trait、型、moduleを増やさない。breaking changeが必要なら影響と移行方法を明示する。
5. 対象projectのrootをカレントディレクトリにして、`<skill-root>/scripts/strict-clippy.sh`を実行する。必要なworkspace、package、target、feature optionはrunnerへ渡す。続けて、対象projectまたはworkspaceが指定する通常のClippy commandを実行し、format・test・feature matrixもprojectの方針に従って検証する。

## Reference guide

必要な判断に対応するfileだけを開く。該当先が明確でない場合は、[API summary](references/rust-api-guidelines/src/SUMMARY.md) または [Patterns summary](references/rust-design-patterns/src/SUMMARY.md) で候補を絞り、本文を一括で読まない。

### API and internal design

type、trait、function、method、macro、moduleを変更するときは、公開範囲にかかわらずAPI Guidelinesを使う。最初に[checklist](references/rust-api-guidelines/src/checklist.md)から該当する`C-*`項目を選び、命名、予測可能性、柔軟性、型安全性、信頼性など内部実装にも有効な規則を適用する。downstream互換性、crate metadata、public documentationなど公開surfaceを前提とする規則だけは公開APIに限定する。

| こういう場合に読む | 参照先と確認内容 |
| --- | --- |
| type、trait、method、moduleの名前を決める。getter、conversion、iteratorの命名やcost表現を確認する | [naming](references/rust-api-guidelines/src/naming.md) — case、`as_` / `to_` / `into_`、getter、iteratorの規約 |
| 標準traitを実装する。Serde連携、error type、`Read` / `Write`との相互運用を設計する | [interoperability](references/rust-api-guidelines/src/interoperability.md) — common trait、error、serialization、I/Oの期待 |
| public macroまたはderive macroを追加・変更する | [macros](references/rust-api-guidelines/src/macros.md) — invocation、attribute、衛生性、診断、将来の拡張性 |
| rustdoc、example、failure条件、crate metadataを追加・レビューする | [documentation](references/rust-api-guidelines/src/documentation.md) — crate docs、example、`# Errors` / `# Panics` / `# Safety`、metadata |
| public/privateを問わずfunctionをmethodにするか、constructorをどう表すか、`Deref`やoperatorを実装するか判断する | [predictability](references/rust-api-guidelines/src/predictability.md) — 明確なreceiverを持つ処理はmethodに置き、constructor、conversion、operatorを予測可能にする |
| 引数をborrow・owned・genericのどれで受けるか、trait objectを公開するか判断する | [flexibility](references/rust-api-guidelines/src/flexibility.md) — caller control、generic bound、object safety |
| primitive引数、boolean、newtype、builder、flag表現を選ぶ | [type safety](references/rust-api-guidelines/src/type-safety.md) — 無効値や引数の取り違えを型で防ぐ条件 |
| validation、panic条件、destructorの失敗や副作用を設計する | [dependability](references/rust-api-guidelines/src/dependability.md) — input validation、panic、dropの契約 |
| public typeの`Debug`表現を決める。非空・非exhaustiveな出力を確認する | [debuggability](references/rust-api-guidelines/src/debuggability.md) — `Debug`の可用性と安定性 |
| downstream互換性、sealed trait、private field、実装表現の隠蔽を判断する | [future proofing](references/rust-api-guidelines/src/future-proofing.md) — 後から拡張できるpublic surface |
| toolchain安定性、crate名、licenseを公開前に確認する | [necessities](references/rust-api-guidelines/src/necessities.md) — stable Rustとpermissive licenseの基本条件 |

API Guidelinesはpublic APIを主対象とするが、読みやすく予測可能な設計の原則はprivate helperやapplication内部にも積極的に適用する。公開互換性や外部利用者を前提とする規則だけを内部codeへ持ち込まない。既存methodを短くすることだけを目的に独立関数へ移さず、明確なreceiver、型のinvariant、状態遷移を扱う処理はその型のmethodに置く。独立関数は、自然なreceiverがない、複数の値を対等に扱う、または型の責務から独立した変換である場合に使う。

### Idioms, patterns, and anti-patterns

既存実装を単純化する候補や、導入しようとしているpatternのtrade-offを調べるときに使う。

| こういう場合に読む | 参照先と確認内容 |
| --- | --- |
| `&String`、`&Vec<T>`、`&Box<T>`を受けている。APIをborrowed formへ一般化したい | [borrowed arguments](references/rust-design-patterns/src/idioms/coercion-arguments.md) |
| borrow checkerを通すためだけにcloneしている | [clone anti-pattern](references/rust-design-patterns/src/anti_patterns/borrow_clone.md) — scope、field分割、`mem::take`等の代替を検討する |
| constructor、`Default`、drop時の後処理、stack上のdynamic dispatchを設計する | [constructor](references/rust-design-patterns/src/idioms/ctor.md)、[Default](references/rust-design-patterns/src/idioms/default.md)、[finalisation](references/rust-design-patterns/src/idioms/dtor-finally.md)、[on-stack dispatch](references/rust-design-patterns/src/idioms/on-stack-dyn-dispatch.md) |
| `Deref`をmethod forwardingや継承の代用にしようとしている | [collections and Deref](references/rust-design-patterns/src/idioms/deref.md) と [Deref anti-pattern](references/rust-design-patterns/src/anti_patterns/deref.md) |
| FFIでerror、string、object-style API、wrapperを設計する | [FFI idioms](references/rust-design-patterns/src/idioms/ffi/intro.md) と [FFI patterns](references/rust-design-patterns/src/patterns/ffi/intro.md)から該当項目を読む |
| newtypeまたはbuilderの導入を検討する | [newtype](references/rust-design-patterns/src/patterns/behavioural/newtype.md)、[builder](references/rust-design-patterns/src/patterns/creational/builder.md) — 利点だけでなく追加される型と状態を確認する |
| resource cleanup、scope guard、RAIIを設計する | [RAII guards](references/rust-design-patterns/src/patterns/behavioural/RAII.md) |
| command、strategy、visitor等のbehavioral patternを検討する | [behavioural patterns](references/rust-design-patterns/src/patterns/behavioural/intro.md)から現在必要なpatternだけを読む |
| structの合成、crate分割、unsafe隔離、複雑なtrait boundの整理を検討する | [structural patterns](references/rust-design-patterns/src/patterns/structural/intro.md)から該当項目を読む |
| `#[deny(warnings)]`をlibrary方針にしようとしている | [deny warnings anti-pattern](references/rust-design-patterns/src/anti_patterns/deny-warnings.md) |
| functional styleやgenericをtype classとして扱う設計を検討する | [functional programming](references/rust-design-patterns/src/functional/index.md)から該当項目を読む |

### Clippy files

| こういう場合に読む | 参照先と確認内容 |
| --- | --- |
| strict runnerが有効にするlintを確認する | [clippy-lints.txt](assets/clippy-lints.txt)を正本として読む |
| complexityやsizeなどのClippy閾値を確認する | [clippy.toml](assets/clippy.toml)を正本として読む |
| runnerが上書きする規約や環境設定を確認する | [strict-clippy.sh](scripts/strict-clippy.sh)を正本として読む |
| lintを修正するか、`#[expect]` / `#[allow]`を置くか判断する | 下の「Strict Clippy」に従う |
| unsafe codeまたはunsafe関連lintを扱う | [unsafe modules](references/rust-design-patterns/src/patterns/structural/unsafe-mods.md)を読み、安全な代替、境界の隔離、`# Safety`と各`unsafe` blockの根拠を確認する |

## Crate guide

次の表は汎用的な候補例であり、推奨crateの固定listではない。まず必要な機能、API、性能、MSRV、feature、`no_std`、licenseなどの要件を明確にする。標準library、既存依存、小さな手書き実装も比較し、現在の反復やerror-proneな実装を減らす場合だけ依存を追加する。

要件を満たす十分に保守されたcrateが存在するか、導入時点のregistry情報、source repository、release履歴、未解決issue、security advisoryを調査する。下表の候補を採用する場合も、記憶や表の説明だけで実装せず、実装前にregistryの最新releaseと選定versionの最新公式documentationを確認する。現在のAPI、feature flag、default feature、MSRV、互換性やmigration上の注意を読み、projectが固定するversionとdocumentationのversionを一致させる。依存の型、attribute、生成API、wire formatがpublic APIへ露出する影響も確認する。導入後はprojectの固定toolchainで、default、no-default、代表feature、all-features、必要なtargetと`no_std`構成をproject方針に合わせて検証する。

| 典型的な要求 | 候補例 | 避ける場合 |
| --- | --- | --- |
| library/domainの分類可能なerror | `thiserror` | application最上位の任意error集約 |
| binary/application最上位のcontext付きerror集約 | `anyhow` | libraryのpublic error type |
| 外部formatとのserialization | `serde` | 内部型への無差別derive |
| request、form、config等の複数field・nested・条件付きvalidation | `garde` | 単純な一回限りの検証、またはconstructorや型で常に保証すべきdomain invariant |
| enumのparse、display、列挙、variant名 | `strum` | 小さな一回限りの`match` |
| newtype/wrapperの自然なtrait delegation | `derive_more` | 意味のない`Deref`、演算、conversion |
| 多数の必須・任意値を持つ段階的構築 | `bon` | 少数fieldまたは一箇所だけの構築 |
| 独立して組み合わせるflag集合 | `bitflags` | 排他的状態やstate machine |
| 計測可能なzero-copy archive access | `rkyv` | 汎用wire formatや互換性未設計の永続化 |
| 非同期I/O runtime | `tokio` | library内のruntime生成や同期処理の単なる置換 |
| cancellation、task追跡、codec、I/O adapter | `tokio-util` | `tokio`だけで十分な処理 |
| Tokio型を`Stream`として扱う | `tokio-stream` | `Future`や一件の非同期結果 |
| `dyn` dispatchが必要なasync trait | `async-trait` | static dispatchや標準のtrait内`async fn`で足りる場合 |
| 非同期処理の構造化された診断 | `tracing` | libraryでのglobal subscriber設定や機密値の記録 |

## Strict Clippy

- runnerは受け取ったoptionを`cargo clippy`へ透過し、その後に規約lintを渡す。例えば全featureを検証するときは`strict-clippy.sh --all-features`を実行する。`--fix`は使わない。標準出力と標準エラーは加工せず引き渡す。続けて、project固有の通常のClippy commandを別に実行する。
- lintは実害があれば修正する。意図したcodeは最小itemに具体的な`reason`付き`#[expect]`を置き、`cfg`やtoolchain差で不安定な場合だけ`#[allow]`を使う。
- crate全体のlint group抑制や、理由のないlint抑制を使わない。testのpanic、unwrap、indexing、標準出力も自動許可しない。

## Completion

- 変更したpublic/private codeの命名、責務、制御flow、所有権を読み手が局所的に理解できる。
- 変更に該当するAPI Guidelinesのchecklist項目を確認し、内部codeにも有効な規則を適用した。
- 追加したstruct、trait、newtype、builder、helper、dependencyの必要性を説明できる。
- 追加した独立関数に自然なreceiverがなく、既存methodを短くするためだけの分割ではない。
- 追加・更新したcrateについて、registryの最新releaseと選定versionの公式documentationを確認した。
- public API、MSRV、feature、`no_std`、generated APIの互換性を確認した。
- error、panic、validation、unsafe、async境界の契約をcallerに明確にした。
- 不要なallocation、clone、boxing、reference counting、interior mutability、lint抑制を増やしていない。
