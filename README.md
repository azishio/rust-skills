# Rust Skills

[English](README.md) | [日本語](ja.md)

Rust Skills maintains and publishes Codex skills for Rust. Installable skills live
in [`skills/`](skills/); this README and the [`justfile`](justfile) contain the
repository's maintainer documentation and setup procedures.

## Included skill

### `write-idiomatic-rust`

Use this skill to implement, modify, review, and refactor Rust code while
holding public APIs and internal implementations to the same quality bar. It
routes relevant decisions to Rust API Guidelines, Microsoft Pragmatic Rust
Guidelines, and Rust Design Patterns, covering naming, function and method
placement, types, ownership, error design, readability, and predictability.
The strict Clippy runner complements rather than replaces a project's own
Clippy command.

The crate guide is not a fixed list of recommended dependencies. It offers
examples to compare with the standard library, existing dependencies, and
small hand-written implementations. For example, `garde` may suit multi-field,
nested, or conditional validation for requests, forms, and configuration. Before
adopting any candidate crate, check the latest registry release and the official
documentation for the selected version, then match its API, features, MSRV, and
compatibility with the project's requirements.

## Setup

```bash
git clone --recurse-submodules <repository-url>
cd rust-skills
just setup
```

`just setup` initializes submodules at the revisions recorded by the
superproject, then sparse-checks out the required `src/` directories and their
license texts. These submodules are runtime reference material for the skill and
must be initialized before packaging or installing it. Installed skills do not
run Just recipes.

## Updating references

`just update-references` advances the Rust API Guidelines, Microsoft Pragmatic
Rust Guidelines, and Rust Design Patterns submodules to the tips of their
tracked branches. It changes the superproject's gitlinks, so review the result
before committing it. In contrast, ordinary `just setup` returns submodules to
their recorded revisions for reproducible skill use.

## Layout

- `skills/`: distributable agent skills, each containing only execution
  instructions, agent reference material, and helper scripts.
- `justfile`: post-clone initialization, reference updates, and sparse-checkout
  settings.
- `README.md` and `ja.md`: maintainer and user documentation in English and
  Japanese.

## License

Files authored for this repository are dual-licensed under either the
[MIT License](LICENSE-MIT) or the [Apache License, Version 2.0](LICENSE-APACHE),
at the recipient's option. Unless explicitly stated otherwise, contributions are
accepted under the same terms.

The submodules under `skills/write-idiomatic-rust/references/` are independent
upstream projects and are not covered by these licenses. See
[Third-party notices](THIRD_PARTY_NOTICES.md) for their licenses and distribution
requirements. When distributing an archive or package containing reference
material, initialize its submodules and retain their applicable license texts
and notices.

## Upstream references

- `rust-lang/api-guidelines` (`master`): Rust API Guidelines; Apache-2.0 OR MIT.
- `microsoft/rust-guidelines` (`main`): Pragmatic Rust Guidelines; MIT.
- `rust-unofficial/patterns` (`main`): Rust Design Patterns; MPL-2.0.

The superproject records each pinned revision as a gitlink. This README,
`.gitmodules`, and [Third-party notices](THIRD_PARTY_NOTICES.md) maintain the
source, revision, and license information rather than embedding it in the skill.
