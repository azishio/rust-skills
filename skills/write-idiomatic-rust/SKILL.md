---
name: write-idiomatic-rust
description: Implement, fix, review, and refactor readable, idiomatic, maintainable Rust across public APIs and internal implementations. Use for types, ownership, error design, function and method placement, dependencies, Rust design guidelines and patterns, and Clippy findings.
---

# Write Idiomatic Rust

Prioritize the user's request, project instructions, existing conventions, compatibility, and supported toolchain. Hold public and internal code to the same standards of readability, predictability, type safety, and maintainability, but apply rules about downstream compatibility, publishing, or public documentation only to public surfaces.

Keep work scoped to the task. Add a helper, trait, type, module, or dependency only when it provides a concrete benefit to responsibility, ownership, type safety, or current duplication.

## Workflow

1. Inspect the relevant `Cargo.toml`, workspace structure, edition, `rust-version`, features, `no_std` support, dependencies, nearby code, and tests. Do not inventory unrelated parts of the project.
2. Identify the concrete decisions introduced by the task: affected APIs and types, ownership and error boundaries, construction paths, function or method placement, compatibility constraints, and validation needs.
3. Use Reference routing below. Start with the smallest matching guide and open only the upstream pages tied to a concrete decision. Expand only when the code or requirements expose another decision. Record applicable guidance and material deviations; do not enumerate irrelevant rules.
4. Implement or recommend the smallest design that preserves behavior and compatibility while keeping responsibility, data flow, and ownership locally understandable. State the impact and migration path for any required breaking change.
5. Validate according to task type:
   - For an implementation, fix, or refactor that changes the Rust project, run `<skill-root>/scripts/strict-clippy.sh` from the target project's root with the needed package, target, and feature options. Then run the project's normal Clippy command and its required formatting, tests, and supported feature or target checks. Follow [Clippy policy](references/clippy-policy.md).
   - For a review without code changes, run targeted non-mutating diagnostics only when they materially support the review; strict Clippy is optional unless the user or project requires it.
   - For design advice or explanation without project changes, do not run validation commands unless they are needed to answer accurately.
   - Keep validation proportional to the affected scope. Report blocked checks and unrelated or pre-existing failures instead of expanding the task to fix them.

## Test selection

- Add a test only when it can fail because of project-owned behavior: project logic or contracts, dependency integration or configuration, or a known regression. If no such failure exists, do not add the test.
- Do not test the standard library or a dependency in isolation. In particular, do not add compile-pass or compile-fail tests merely to confirm that dependency-provided macros, derives, type-state APIs, or required inputs behave as documented.
- Test dependency-related behavior only where the project adds a contract, such as configuration, mapping, wrappers, wire formats, supported feature or target combinations, or a regression at the integration boundary. Exercise the smallest observable project boundary.
- Reserve compile-pass and compile-fail tests for compile-time contracts authored by the project or documented regressions in project-owned integration.
- Prefer a small set of high-signal behavior tests. Do not mirror implementation branches or add tests solely to increase coverage.

## Reference routing

Read only guides that match the current decision:

- **API or internal design**: For naming, standard traits, error types, functions versus methods, argument ownership, constructors, builders, type safety, panics, `Debug`, documentation, or public compatibility, read [API and internal design](references/api-and-internal-design.md).
- **Production engineering**: For library or application architecture, workspace layout, features, macros, FFI, unsafe code, performance, logging, documentation, MSRV, or structure specifically intended for AI-assisted maintenance, read [Pragmatic engineering](references/pragmatic-engineering.md).
- **Idioms and patterns**: For borrow-checker clones, borrowed arguments, `Deref`, constructors, RAII, newtypes, builders, FFI patterns, or structural and behavioral patterns, read [Idioms and patterns](references/idioms-and-patterns.md).
- **Control and data flow**: When choosing iterators or combinators versus loops, mutation, or `match`, read [Data flow](references/data-flow.md).
- **Dependencies**: Before evaluating, adding, or updating a crate, read [Dependency selection](references/dependencies.md).
- **Clippy**: Before running the strict runner or resolving, suppressing, or assessing a lint, read [Clippy policy](references/clippy-policy.md).

If no route clearly fits, narrow the destination with the [API summary](references/rust-api-guidelines/src/SUMMARY.md), [Pragmatic summary](references/microsoft-rust-guidelines/src/SUMMARY.md), or [Patterns summary](references/rust-design-patterns/src/SUMMARY.md). Search headings or checklist identifiers before opening a long file; never load all vendored references or an entire checklist by default.

## Completion

- Preserve behavior and public compatibility, or clearly state intentional breakage and migration.
- Make changed public and internal code locally understandable in naming, responsibility, control flow, and ownership.
- Apply guidance relevant to actual decisions and explain only consequential trade-offs or deviations.
- For changed Rust projects, run strict Clippy and project-required checks, or report why a check could not complete.
- Ensure every added test protects project-owned behavior, contracts, integration, configuration, or a known regression rather than revalidating the standard library or a dependency.
- Avoid unnecessary abstractions, dependencies, allocations, clones, boxing, shared ownership, interior mutability, and lint suppression.
- Make applicable error, panic, validation, unsafe, async, feature, MSRV, and `no_std` contracts clear.
