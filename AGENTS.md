# Repository guidance

## Layout

- `skills/` contains only files an agent needs to execute a skill.
- `README.md` and `justfile` are for repository maintainers; do not direct an installed skill to run Just recipes.
- The reference submodules are required runtime material and must be initialized before packaging or installing a skill.

## Version control

- GitButler does not support submodules and may ignore gitlinks. Use Git directly for all version-control inspection and write operations in this repository.
- Preserve unrelated work when using Git, and commit each task on its own branch.

## Updating references

Run `just update-references` only for intentional upstream updates. It advances submodules and changes the parent repository's gitlinks.

When that recipe changes any reference submodule, update `skills/write-idiomatic-rust/SKILL.md` in the same change:

1. Compare the current `src/SUMMARY.md` files and linked reference paths with its `Reference guide`.
2. Update, add, or remove routes for renamed, moved, added, or deleted upstream sections.
3. Check every Markdown link in the guide resolves in the initialized submodules.

Run `just setup`, `just --fmt --check`, and the skill validator after changing references or the skill instructions.
