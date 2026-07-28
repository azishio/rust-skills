# Idioms and patterns

Read this guide when simplifying existing code or evaluating a pattern. Open only the row tied to the current decision. Read both benefits and drawbacks before introducing a named pattern; do not add a pattern merely because the code resembles its example.

If no row fits, inspect the [Patterns summary](rust-design-patterns/src/SUMMARY.md) and open one candidate page at a time.

| Read when | Reference and check |
| --- | --- |
| Receiving `&String`, `&Vec<T>`, or `&Box<T>` and generalizing an API to its borrowed form | [borrowed arguments](rust-design-patterns/src/idioms/coercion-arguments.md) |
| Cloning only to satisfy the borrow checker | [clone anti-pattern](rust-design-patterns/src/anti_patterns/borrow_clone.md) — consider scopes, field splitting, and `mem::take` |
| Designing constructors, `Default`, cleanup on drop, or on-stack dynamic dispatch | [constructor](rust-design-patterns/src/idioms/ctor.md), [Default](rust-design-patterns/src/idioms/default.md), [finalisation](rust-design-patterns/src/idioms/dtor-finally.md), or [on-stack dispatch](rust-design-patterns/src/idioms/on-stack-dyn-dispatch.md) |
| Using `Deref` for method forwarding or as a substitute for inheritance | [collections and Deref](rust-design-patterns/src/idioms/deref.md) and [Deref anti-pattern](rust-design-patterns/src/anti_patterns/deref.md) |
| Designing FFI errors, strings, object-style APIs, or wrappers | Read the applicable item from [FFI idioms](rust-design-patterns/src/idioms/ffi/intro.md) or [FFI patterns](rust-design-patterns/src/patterns/ffi/intro.md) |
| Considering a newtype or builder | [newtype](rust-design-patterns/src/patterns/behavioural/newtype.md) and [builder](rust-design-patterns/src/patterns/creational/builder.md) — assess added types and states as well as benefits |
| Designing resource cleanup, scope guards, or RAII | [RAII guards](rust-design-patterns/src/patterns/behavioural/RAII.md) |
| Considering command, strategy, visitor, or another behavioral pattern | Read only the relevant item from [behavioral patterns](rust-design-patterns/src/patterns/behavioural/intro.md) |
| Considering struct composition, crate splits, unsafe isolation, or simplifying complex trait bounds | Read the relevant item from [structural patterns](rust-design-patterns/src/patterns/structural/intro.md); for unsafe code, include [unsafe modules](rust-design-patterns/src/patterns/structural/unsafe-mods.md) |
| Considering `#[deny(warnings)]` as a library policy | [deny warnings anti-pattern](rust-design-patterns/src/anti_patterns/deny-warnings.md) |
| Choosing declarative versus imperative flow or treating generics as type classes | Read [Data flow](data-flow.md) and the relevant item from [functional programming](rust-design-patterns/src/functional/index.md), beginning with [programming paradigms](rust-design-patterns/src/functional/paradigms.md) |
