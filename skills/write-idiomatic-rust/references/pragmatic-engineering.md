# Pragmatic engineering

Read this guide for production libraries, applications, workspaces, performance, documentation, FFI, unsafe code, or code and documentation specifically intended for AI-assisted maintenance. Treat the Microsoft Pragmatic Rust Guidelines as decision support, not universal requirements. Prioritize project requirements, existing conventions, compatibility, MSRV, deployment constraints, and measurements.

Start with the narrow category index below, then open only the applicable `M-*` pages linked from it. Use the [Pragmatic summary](microsoft-rust-guidelines/src/SUMMARY.md) or search the [checklist](microsoft-rust-guidelines/src/guidelines/checklist/README.md) only when the category is unclear; do not read the full checklist by default. Read conditions and trade-offs before adopting opinionated guidance such as allocator changes, `target-cpu`, crate splits, async designs, or builders.

| Read when | Reference and check |
| --- | --- |
| Checking cross-cutting naming, function placement, lint suppression, logging, or crate splits | [universal](microsoft-rust-guidelines/src/guidelines/universal/README.md) — upstream conventions, static verification, `#[expect]`, short names, and structured logging |
| Designing library types, errors, I/O, modules, builders, testability, resilience, or features | Read the matching index from [libraries](microsoft-rust-guidelines/src/guidelines/libs/README.md), [interoperability](microsoft-rust-guidelines/src/guidelines/libs/interop/README.md), [UX](microsoft-rust-guidelines/src/guidelines/libs/ux/README.md), [resilience](microsoft-rust-guidelines/src/guidelines/libs/resilience/README.md), or [building](microsoft-rust-guidelines/src/guidelines/libs/building/README.md) |
| Deciding whether to use a declarative or procedural macro and how to structure generated APIs | [macros](microsoft-rust-guidelines/src/guidelines/macros/README.md) |
| Designing binary or application errors, allocators, or CPU targets | [applications](microsoft-rust-guidelines/src/guidelines/apps/README.md) — distinguish applications from libraries and require deployment evidence |
| Designing FFI crate names, boundaries with business logic, or DLL state | [FFI](microsoft-rust-guidelines/src/guidelines/ffi/README.md) |
| Evaluating unsafe code, soundness, panic contracts, or whether execution may continue | [correctness](microsoft-rust-guidelines/src/guidelines/correctness/README.md) |
| Improving a hot path, allocations, indirection, hashing, async stacks, or telemetry overhead | [performance](microsoft-rust-guidelines/src/guidelines/performance/README.md) — profile and benchmark before changing the design |
| Choosing workspace structure, crate placement, editions, or MSRV | [project](microsoft-rust-guidelines/src/guidelines/project/README.md) |
| Improving module docs, opening sentences, canonical sections, or rustdoc re-export display | [documentation](microsoft-rust-guidelines/src/guidelines/docs/README.md) |
| Improving Rust-native structure, public paths, tests, or design documentation for AI changes | [AI](microsoft-rust-guidelines/src/guidelines/ai/README.md) — preserve human readability and project policy |
