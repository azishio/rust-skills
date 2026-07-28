# API and internal design

Read this guide only for a concrete API or internal design decision. Apply readable and predictable API Guidelines principles to private helpers and application internals, but limit rules that assume downstream users, publishing, or public documentation to public surfaces.

Use the most specific row below. Open the linked page and only the relevant `C-*` sections. If the category is uncertain, inspect the [API summary](rust-api-guidelines/src/SUMMARY.md) or search the [checklist](rust-api-guidelines/src/checklist.md) for decision terms or known identifiers instead of reading it top to bottom.

| Read when | Reference and check |
| --- | --- |
| Naming types, traits, methods, or modules; checking getter, conversion, iterator, or cost naming | [naming](rust-api-guidelines/src/naming.md) — casing, `as_` / `to_` / `into_`, getters, and iterators |
| Implementing standard traits or designing Serde integration, error types, or `Read` / `Write` interoperability | [interoperability](rust-api-guidelines/src/interoperability.md) — common traits, errors, serialization, and I/O expectations |
| Adding or changing a public macro or derive macro | [macros](rust-api-guidelines/src/macros.md) — invocations, attributes, hygiene, diagnostics, and future extensibility |
| Adding or reviewing rustdoc, examples, failure conditions, or crate metadata | [documentation](rust-api-guidelines/src/documentation.md) — crate docs, examples, `# Errors` / `# Panics` / `# Safety`, and metadata |
| Choosing functions versus methods, constructor representation, or whether to implement `Deref` or operators | [predictability](rust-api-guidelines/src/predictability.md) — receivers, constructors, conversions, and operators |
| Choosing borrowed, owned, or generic arguments, or exposing trait objects | [flexibility](rust-api-guidelines/src/flexibility.md) — caller control, generic bounds, and object safety |
| Choosing primitive arguments, booleans, newtypes, builders, or flag representations | [type safety](rust-api-guidelines/src/type-safety.md) — prevent invalid values and swapped arguments through types |
| Designing validation, panic conditions, destructor failures, or side effects | [dependability](rust-api-guidelines/src/dependability.md) — validation, panic, and drop contracts |
| Deciding a public type's `Debug` representation | [debuggability](rust-api-guidelines/src/debuggability.md) — useful and stable non-empty output |
| Evaluating downstream compatibility, sealed traits, private fields, or implementation hiding | [future proofing](rust-api-guidelines/src/future-proofing.md) — extensible public surfaces |
| Checking toolchain stability, crate names, or licenses before publishing | [necessities](rust-api-guidelines/src/necessities.md) — stable Rust and permissive-license basics |

Keep operations with a clear receiver, type invariant, or state transition on the type. Use a free function when no natural receiver exists, multiple inputs are peers, or the transformation is independent of a type's responsibility. Do not extract a method merely to shorten it.
