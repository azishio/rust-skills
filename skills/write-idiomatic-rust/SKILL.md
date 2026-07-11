---
name: write-idiomatic-rust
description: Implement, fix, review, and refactor readable, idiomatic, maintainable Rust across public APIs and internal implementations. Use for types, ownership, error design, function and method placement, dependencies, Rust design guidelines and patterns, and Clippy findings.
---

# Write Idiomatic Rust

Apply the same standards of readability, predictability, type safety, and maintainability to every change, regardless of visibility. Prioritize existing conventions and requirements, and proactively locate and apply relevant rules from the API Guidelines, Pragmatic Rust Guidelines, and design patterns. Consider each rule's purpose and trade-offs, and be able to explain why an inapplicable rule was excluded. Add abstractions or dependencies only when they provide a concrete benefit to ownership, type safety, responsibility, or duplication reduction.

## Workflow

1. Inspect `Cargo.toml`, the workspace, visibility, edition, `rust-version`, features, `no_std`, existing dependencies, and relevant tests.
2. Identify every affected API, type, ownership boundary, error, function or method placement, and construction path, whether public or private. Prefer existing names and conventions.
3. Use the Reference guide below to actively select the checklist items and files relevant to the change. Apply the same design standards to internal implementations except for rules that apply only to public APIs. Evaluate opinionated Pragmatic Rust Guidelines against project requirements and measurements; read both benefits and drawbacks for patterns.
4. Implement the smallest design that lets readers follow responsibility, data flow, and ownership, while preserving behavior and public compatibility. Do not add helpers, traits, types, or modules merely for brevity or possible reuse. If a breaking change is required, state its impact and migration path.
5. From the target project's root, run `<skill-root>/scripts/strict-clippy.sh`. Pass needed workspace, package, target, and feature options to the runner. Then run the normal Clippy command required by the project or workspace, and validate formatting, tests, and the feature matrix according to project policy.

## Reference guide

Open only the files needed for the decision at hand. When the destination is unclear, narrow the candidates with the [API summary](references/rust-api-guidelines/src/SUMMARY.md), [Pragmatic summary](references/microsoft-rust-guidelines/src/SUMMARY.md), or [Patterns summary](references/rust-design-patterns/src/SUMMARY.md); do not read the full bodies indiscriminately.

### API and internal design

Use the API Guidelines whenever changing a type, trait, function, method, macro, or module, regardless of visibility. Start with the relevant `C-*` items in the [checklist](references/rust-api-guidelines/src/checklist.md), applying rules useful to internal code as well, such as naming, predictability, flexibility, type safety, and dependability. Limit rules that assume downstream compatibility, crate metadata, or public documentation to public APIs.

| Read when | Reference and check |
| --- | --- |
| Naming types, traits, methods, or modules; checking getter, conversion, iterator, or cost naming | [naming](references/rust-api-guidelines/src/naming.md) — casing, `as_` / `to_` / `into_`, getters, and iterators |
| Implementing standard traits or designing Serde integration, error types, or `Read` / `Write` interoperability | [interoperability](references/rust-api-guidelines/src/interoperability.md) — common traits, errors, serialization, and I/O expectations |
| Adding or changing a public macro or derive macro | [macros](references/rust-api-guidelines/src/macros.md) — invocations, attributes, hygiene, diagnostics, and future extensibility |
| Adding or reviewing rustdoc, examples, failure conditions, or crate metadata | [documentation](references/rust-api-guidelines/src/documentation.md) — crate docs, examples, `# Errors` / `# Panics` / `# Safety`, and metadata |
| Choosing functions versus methods, constructor representation, or whether to implement `Deref` or operators | [predictability](references/rust-api-guidelines/src/predictability.md) — put operations with a clear receiver on methods and keep constructors, conversions, and operators predictable |
| Choosing borrowed, owned, or generic arguments, or exposing trait objects | [flexibility](references/rust-api-guidelines/src/flexibility.md) — caller control, generic bounds, and object safety |
| Choosing primitive arguments, booleans, newtypes, builders, or flag representations | [type safety](references/rust-api-guidelines/src/type-safety.md) — conditions for preventing invalid values and swapped arguments through types |
| Designing validation, panic conditions, destructor failures, or side effects | [dependability](references/rust-api-guidelines/src/dependability.md) — contracts for validation, panics, and drop |
| Deciding a public type's `Debug` representation | [debuggability](references/rust-api-guidelines/src/debuggability.md) — useful and stable non-empty output |
| Evaluating downstream compatibility, sealed traits, private fields, or implementation hiding | [future proofing](references/rust-api-guidelines/src/future-proofing.md) — extensible public surfaces |
| Checking toolchain stability, crate names, or licenses before publishing | [necessities](references/rust-api-guidelines/src/necessities.md) — stable Rust and permissive-license basics |

Although the API Guidelines primarily target public APIs, actively apply their readable and predictable design principles to private helpers and application internals. Do not transfer rules that specifically assume public compatibility or external users into internal code. Do not move existing methods into free functions merely to shorten them: keep operations with a clear receiver, type invariants, or state transitions on that type's methods. Use a free function only when no natural receiver exists, multiple values are peers, or the transformation is independent of a type's responsibility.

### Pragmatic engineering guidelines

For decisions concerning production libraries, applications, workspaces, performance, documentation, or AI-assisted development, use the Microsoft Pragmatic Rust Guidelines. Start with the relevant `M-*` items in the [checklist](references/microsoft-rust-guidelines/src/guidelines/checklist/README.md). Do not treat the rules as universal requirements: prioritize the target project's requirements, existing conventions, compatibility, MSRV, deployment environment, and profiling results. Read the applicable conditions and trade-offs before choosing an allocator, `target-cpu`, crate split, async design, builder, or similar option.

| Read when | Reference and check |
| --- | --- |
| Checking cross-cutting rules for naming, function placement, lint suppression, logging, or crate splits | [universal](references/microsoft-rust-guidelines/src/guidelines/universal/README.md) — upstream conventions, static verification, `#[expect]`, short names, and structured logging |
| Designing library types, errors, I/O, modules, builders, testability, or features | Read relevant items from [libraries](references/microsoft-rust-guidelines/src/guidelines/libs/README.md), [interoperability](references/microsoft-rust-guidelines/src/guidelines/libs/interop/README.md), [UX](references/microsoft-rust-guidelines/src/guidelines/libs/ux/README.md), [resilience](references/microsoft-rust-guidelines/src/guidelines/libs/resilience/README.md), and [building](references/microsoft-rust-guidelines/src/guidelines/libs/building/README.md) |
| Deciding whether to use a declarative or procedural macro and its structure or generated surface | [macros](references/microsoft-rust-guidelines/src/guidelines/macros/README.md) — conditions for macros, helpers, impl crates, and generated items |
| Designing binary or application errors, allocators, or CPU targets | [applications](references/microsoft-rust-guidelines/src/guidelines/apps/README.md) — distinguish libraries, and decide allocators and targets from deployment requirements and measurements |
| Designing FFI crate names, boundaries with business logic, or DLL state | [FFI](references/microsoft-rust-guidelines/src/guidelines/ffi/README.md) |
| Evaluating unsafe code, soundness, panic contracts, or whether execution may continue | [correctness](references/microsoft-rust-guidelines/src/guidelines/correctness/README.md) |
| Improving a hot path, allocations, indirection, hashing, async stacks, or telemetry overhead | [performance](references/microsoft-rust-guidelines/src/guidelines/performance/README.md) — profile and benchmark before applying changes |
| Choosing workspace structure, crate placement, editions, or MSRV | [project](references/microsoft-rust-guidelines/src/guidelines/project/README.md) |
| Improving module docs, opening sentences, canonical sections, or rustdoc re-export display | [documentation](references/microsoft-rust-guidelines/src/guidelines/docs/README.md) |
| Improving Rust-native structure, public paths, tests, or design documentation for AI changes | [AI](references/microsoft-rust-guidelines/src/guidelines/ai/README.md) — apply while preserving human readability and project policy |

### Idioms, patterns, and anti-patterns

Use these references when simplifying existing code or examining the trade-offs of a proposed pattern.

| Read when | Reference and check |
| --- | --- |
| Receiving `&String`, `&Vec<T>`, or `&Box<T>` and generalizing an API to its borrowed form | [borrowed arguments](references/rust-design-patterns/src/idioms/coercion-arguments.md) |
| Cloning only to satisfy the borrow checker | [clone anti-pattern](references/rust-design-patterns/src/anti_patterns/borrow_clone.md) — consider alternatives such as scopes, field splitting, and `mem::take` |
| Designing constructors, `Default`, cleanup on drop, or on-stack dynamic dispatch | [constructor](references/rust-design-patterns/src/idioms/ctor.md), [Default](references/rust-design-patterns/src/idioms/default.md), [finalisation](references/rust-design-patterns/src/idioms/dtor-finally.md), and [on-stack dispatch](references/rust-design-patterns/src/idioms/on-stack-dyn-dispatch.md) |
| Using `Deref` for method forwarding or as a substitute for inheritance | [collections and Deref](references/rust-design-patterns/src/idioms/deref.md) and [Deref anti-pattern](references/rust-design-patterns/src/anti_patterns/deref.md) |
| Designing FFI errors, strings, object-style APIs, or wrappers | Read applicable items from [FFI idioms](references/rust-design-patterns/src/idioms/ffi/intro.md) and [FFI patterns](references/rust-design-patterns/src/patterns/ffi/intro.md) |
| Considering a newtype or builder | [newtype](references/rust-design-patterns/src/patterns/behavioural/newtype.md) and [builder](references/rust-design-patterns/src/patterns/creational/builder.md) — assess the added types and states as well as benefits |
| Designing resource cleanup, scope guards, or RAII | [RAII guards](references/rust-design-patterns/src/patterns/behavioural/RAII.md) |
| Considering behavioral patterns such as command, strategy, or visitor | Read only the currently relevant pattern in [behavioural patterns](references/rust-design-patterns/src/patterns/behavioural/intro.md) |
| Considering struct composition, crate splits, unsafe isolation, or simplifying complex trait bounds | Read relevant items from [structural patterns](references/rust-design-patterns/src/patterns/structural/intro.md) |
| Considering `#[deny(warnings)]` as a library policy | [deny warnings anti-pattern](references/rust-design-patterns/src/anti_patterns/deny-warnings.md) |
| Considering functional style or treating generics as type classes | Read relevant items from [functional programming](references/rust-design-patterns/src/functional/index.md) |

### Clippy files

| Read when | Reference and check |
| --- | --- |
| Checking the lints enabled by the strict runner | Treat [clippy-lints.txt](assets/clippy-lints.txt) as authoritative |
| Checking Clippy thresholds such as complexity or size | Treat [clippy.toml](assets/clippy.toml) as authoritative |
| Checking conventions or environment settings overridden by the runner | Treat [strict-clippy.sh](scripts/strict-clippy.sh) as authoritative |
| Deciding whether to fix a lint or add `#[expect]` / `#[allow]` | Follow Strict Clippy below |
| Handling unsafe code or unsafe-related lints | Read [unsafe modules](references/rust-design-patterns/src/patterns/structural/unsafe-mods.md); verify safe alternatives, boundary isolation, `# Safety`, and the rationale for every `unsafe` block |

## Crate guide

The table below provides general candidates, not a fixed list of recommended crates. First identify requirements such as needed functionality, API, performance, MSRV, features, `no_std`, and licenses. Compare the standard library, existing dependencies, and small handwritten implementations; add a dependency only when it reduces current repetition or error-prone code.

Research whether a sufficiently maintained crate satisfies the requirements, including the registry information available at adoption time, source repository, release history, open issues, and security advisories. Even when choosing a candidate below, do not implement from memory or this table alone: before implementation, verify the registry's latest release and the current official documentation for the selected version. Read the current API, feature flags, default features, MSRV, and compatibility or migration notes, and align the project's pinned version with the documentation version. Also consider whether dependency types, attributes, generated APIs, or wire formats become exposed through the public API. After adoption, validate default features, no-default-features, representative features, all features, required targets, and `no_std` configurations on the project's pinned toolchain according to project policy.

| Typical need | Candidate | Avoid when |
| --- | --- | --- |
| Classifiable library or domain errors | `thiserror` | Aggregating arbitrary top-level application errors |
| Contextual aggregation of top-level binary or application errors | `anyhow` | A library's public error type |
| Serialization to or from an external format | `serde` | Blanket derives on internal types |
| Multi-field, nested, or conditional validation for requests, forms, or configuration | `garde` | One-off simple validation, or domain invariants that constructors or types must always guarantee |
| Enum parsing, display, enumeration, or variant names | `strum` | A small one-off `match` |
| Natural trait delegation for a newtype or wrapper | `derive_more` | Meaningless `Deref`, operators, or conversions |
| Staged construction with many required and optional values | `bon` | Few fields or a single construction site |
| Independently combinable flag sets | `bitflags` | Exclusive states or state machines |
| Measurable zero-copy archive access | `rkyv` | General wire formats or persistence without a compatibility plan |
| Asynchronous I/O runtime | `tokio` | Creating a runtime inside a library or merely replacing synchronous work |
| Cancellation, task tracking, codecs, or I/O adapters | `tokio-util` | Work sufficiently handled by `tokio` alone |
| Using Tokio types as `Stream`s | `tokio-stream` | A `Future` or one asynchronous result |
| Async traits requiring `dyn` dispatch | `async-trait` | Cases covered by static dispatch or standard trait `async fn` |
| Structured diagnostics in asynchronous work | `tracing` | Global subscriber setup in a library or recording sensitive values |

## Strict Clippy

- The runner passes received options through to `cargo clippy`, then supplies its policy lints. For example, run `strict-clippy.sh --all-features` to validate all features. Do not use `--fix`. It passes standard output and standard error through unchanged. Then run the project's normal Clippy command separately.
- Fix lints that indicate a real problem. For intentional code, place a specific `#[expect]` with a `reason` on the smallest item; use `#[allow]` only when `cfg` or toolchain differences make the lint unstable.
- Do not suppress crate-wide lint groups or suppress lints without a reason. Do not automatically permit panics, unwraps, indexing, or standard output in tests.

## Completion

- A reader can understand the naming, responsibility, control flow, and ownership of changed public or private code locally.
- Relevant API Guidelines checklist items have been checked, including rules applicable to internal code.
- Relevant `M-*` Pragmatic Rust Guidelines items have been checked, without unconditionally applying rules that conflict with project requirements or measurements.
- You can explain the need for every added struct, trait, newtype, builder, helper, or dependency.
- Every added free function has no natural receiver and was not extracted merely to shorten an existing method.
- For each added or updated crate, you verified the registry's latest release and the official documentation for the selected version.
- You checked compatibility of the public API, MSRV, features, `no_std`, and generated APIs.
- You made contracts for errors, panics, validation, unsafe code, and async boundaries clear to callers.
- You did not add unnecessary allocations, clones, boxing, reference counting, interior mutability, or lint suppression.
