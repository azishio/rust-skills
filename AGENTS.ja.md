# Repository guidance

## 言語版の整合性

- `AGENTS.md`は英語版の指示ファイル、`AGENTS.ja.md`は日本語版です。両者の要件は意味的に同等に保つ。
- どちらかの指示を変更するときは、同じ変更で両方を更新する。意図しない差異は不具合として扱う。

## 構成

- `skills/`には、agentがskillを実行するために必要なfileだけを置く。
- `README.md`、`ja.md`、`justfile`はrepository maintainer向けである。インストール済みskillにJust recipeの実行を指示しない。
- reference submoduleは実行時に必要な資料であり、skillをpackageまたはinstallする前に初期化する。

## Version control

- GitButlerはsubmoduleに対応しておらず、gitlinkを無視することがある。このrepositoryではversion controlの確認・書き込みにGitを直接使用する。
- Gitを使用するときは無関係な作業を保持し、taskごとに専用branchへcommitする。

## 参照資料の更新

意図的なupstream更新に限り`just update-references`を実行する。このrecipeはsubmoduleを進め、親repositoryのgitlinkを変更する。

このrecipeがいずれかのreference submoduleを変更した場合、同じ変更で`skills/write-idiomatic-rust/SKILL.md`を更新する。

1. 現在の`src/SUMMARY.md`と、skillの`Reference guide`からリンクする参照pathを比較する。
2. upstreamでrename、移動、追加、削除されたsectionに応じて、routeを更新、追加、削除する。
3. guideのすべてのMarkdown linkが、初期化済みsubmodule内で解決することを確認する。

referenceまたはskill instructionを変更した後は、`just setup`、`just --fmt --check`、skill validatorを実行する。
