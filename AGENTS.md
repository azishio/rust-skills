# Repository guidance

## Language parity

- `AGENTS.md` is the English instruction file and `AGENTS.ja.md` is its Japanese counterpart. Keep their requirements semantically equivalent.
- Update both files in the same change whenever either file's instructions change; treat any unintended difference as a defect.

## Layout

- `skills/` contains only files an agent needs to execute a skill.
- `README.md` and `.github/workflows/` are for repository maintainers; do not direct an installed skill to run repository automation.
- The vendored reference files are required runtime material and must be kept complete when packaging or installing a skill.

## Version control

- Use Git directly for all version-control inspection and write operations in this repository.
- Preserve unrelated work when using Git, and commit each task on its own branch.

## Updating references

GitHub Actions refreshes vendored references every Monday and records their source lock. Use its workflow dispatch only for an intentional upstream update.

When the workflow changes any vendored reference, update `skills/write-idiomatic-rust/SKILL.md` in the same change:

1. Compare the current `src/SUMMARY.md` files and linked reference paths with its `Reference guide`.
2. Update, add, or remove routes for renamed, moved, added, or deleted upstream sections.
3. Check every Markdown link in the guide resolves in the vendored references.

Run the skill validator after changing references or the skill instructions.
