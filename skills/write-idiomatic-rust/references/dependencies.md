# Dependency selection

Read this guide only when evaluating, adding, or updating a crate. Treat the candidates below as comparison prompts, not fixed recommendations.

1. Define the required functionality, API shape, performance, MSRV, features, targets, `no_std` support, and license constraints.
2. Compare the standard library, existing dependencies, and a small local implementation. Add a dependency only when it reduces current repetition or error-prone code enough to justify its cost.
3. For a new or updated dependency, verify the registry's current release and the official documentation for the selected version. Check its API, default and optional features, MSRV, license, compatibility notes, and security advisories. Inspect the source repository, release history, or open issues when maintenance or operational risk makes them material.
4. Check whether dependency types, attributes, generated APIs, or wire formats become part of a public contract.
5. Validate the feature, target, and `no_std` configurations the project actually claims to support on its pinned toolchain. Do not invent an all-features, no-default-features, target, or `no_std` requirement absent from project policy.

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
| Iterator adapters, multi-iterator operations, or grouping beyond `std` | `itertools` | Standard iterator methods or one clear local loop suffice |
| Insertion-ordered maps or sets with key and index lookup | `indexmap` | Order is irrelevant, sorted-key order is required, or `HashMap` / `BTreeMap` fits |
| Measurable zero-copy archive access | `rkyv` | General wire formats or persistence without a compatibility plan |
| Measured data parallelism for independent CPU-bound work | `rayon` | Small or I/O-bound workloads, order-dependent side effects, constrained targets, or no benchmarked gain |
| Measured fast hashing for trusted, non-adversarial keys | `rustc-hash` | Untrusted input, HashDoS resistance, stable iteration order, or no measured hash bottleneck |
| Asynchronous I/O runtime | `tokio` | Creating a runtime inside a library or merely replacing synchronous work |
| Cancellation, task tracking, codecs, or I/O adapters | `tokio-util` | Work sufficiently handled by `tokio` alone |
| Using Tokio types as `Stream`s | `tokio-stream` | A `Future` or one asynchronous result |
| Async traits requiring `dyn` dispatch | `async-trait` | Cases covered by static dispatch or standard trait `async fn` |
| Structured diagnostics in asynchronous work | `tracing` | Global subscriber setup in a library or recording sensitive values |
