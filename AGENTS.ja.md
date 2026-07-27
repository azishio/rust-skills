# Repository guidance

## 言語版の整合性

- `AGENTS.md`は英語版の指示ファイル、`AGENTS.ja.md`は日本語版です。両者の要件は意味的に同等に保つ。
- どちらかの指示を変更するときは、同じ変更で両方を更新する。意図しない差異は不具合として扱う。

## 構成

- `skills/`には、agentがskillを実行するために必要なfileだけを置く。
- `README.md`、`ja.md`、`.github/workflows/`はrepository maintainer向けである。インストール済みskillにrepository自動化の実行を指示しない。
- vendor済みreferenceは実行時に必要な資料であり、skillをpackageまたはinstallするときに完全な状態を保つ。

## Version control

- このrepositoryではversion controlの確認・書き込みにGitを直接使用する。
- Gitを使用するときは無関係な作業を保持し、taskごとに専用branchへcommitする。

## 参照資料の更新

GitHub Actionsは毎週月曜日にvendor済みreferenceとsource lockを更新する。意図的なupstream更新に限りworkflow dispatchを使用する。

workflowがいずれかのvendor済みreferenceを変更した場合、同じ変更で`skills/write-idiomatic-rust/SKILL.md`を更新する。

1. 現在の`src/SUMMARY.md`と、skillの`Reference guide`からリンクする参照pathを比較する。
2. upstreamでrename、移動、追加、削除されたsectionに応じて、routeを更新、追加、削除する。
3. guideのすべてのMarkdown linkが、vendor済みreference内で解決することを確認する。

referenceまたはskill instructionを変更した後は、skill validatorを実行する。
