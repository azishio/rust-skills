# Contributing

Issues and pull requests are welcome. Keep changes focused and explain the
user-visible or maintenance reason for them.

Before opening a pull request, initialize the reference submodules and run:

```bash
just setup
just --fmt --check
```

When changing a reference submodule, update the routes in
`skills/write-idiomatic-rust/SKILL.md`, check its Markdown links, and run the
skill validator described in `AGENTS.md`.

By submitting a contribution, you agree to license it under either the MIT
License or the Apache License, Version 2.0, at the recipient's option, unless
you explicitly state otherwise in writing.
