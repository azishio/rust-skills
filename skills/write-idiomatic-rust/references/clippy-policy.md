# Clippy policy

Read this guide before running the strict runner or resolving, suppressing, or assessing a lint.

## Running checks

- From the target project's root, run `<skill-root>/scripts/strict-clippy.sh` for implementations, fixes, and refactors. Pass Cargo selection options such as workspace, package, target, and features through to the runner.
- Add `--publishable` only when checking a crate intended for publication. This enables the Cargo lint group and its publication metadata checks; the default strict profile remains suitable for internal crates and applications.
- The runner sets `CLIPPY_CONF_DIR` to the skill's configuration, so it intentionally does not use the project's `clippy.toml`. Run the project's normal Clippy command separately to enforce local policy as well.
- Expand to `--all-features`, additional targets, or the workspace only when project policy or affected scope requires it.
- Inspect version-control status before using `--fix`; use it only when the relevant working tree is clean and its changes are committed. The runner passes standard output and standard error through unchanged.

## Handling findings

- Treat [clippy-lints.txt](../assets/clippy-lints.txt) as the authoritative lint-level list and [clippy.toml](../assets/clippy.toml) as the authoritative strict-runner configuration. Deny-level findings fail the strict check; warning-level findings are review candidates.
- Fix findings that indicate a real problem. If intentional code triggers a lint, place a specific `#[expect]` with a `reason` on the smallest item. Use `#[allow]` only when `cfg` or toolchain differences make an expectation unstable.
- Assess warning-level findings against requirements, MSRV, public compatibility, measurements, and local conventions. Do not add an abstraction or exception solely to silence a warning.
- Report unrelated or pre-existing deny-level failures without changing out-of-scope code.
- In tests, permit `expect` only when its message states the fixture or assertion invariant. Keep production code subject to the configured `expect_used` policy.
- Do not suppress crate-wide lint groups or suppress lints without a reason. Follow configured test allowances while keeping fixtures and assertions clear.
- For unsafe code, read [unsafe modules](rust-design-patterns/src/patterns/structural/unsafe-mods.md), verify safe alternatives and boundary isolation, document `# Safety`, and justify every `unsafe` block.

## Runner files

| Need | Source of truth |
| --- | --- |
| Default lint levels | [clippy-lints.txt](../assets/clippy-lints.txt) |
| Additional publication lint levels | [clippy-publish-lints.txt](../assets/clippy-publish-lints.txt) |
| Complexity, size, test, and other Clippy thresholds | [clippy.toml](../assets/clippy.toml) |
| Environment and argument forwarding | [strict-clippy.sh](../scripts/strict-clippy.sh) |
