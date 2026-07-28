# Data flow

Read this guide only when control-flow style is part of the task.

Prefer describing what value to compute over spelling out step-by-step mutation when both forms remain clear. Use expressions, iterator adapters, and `Option` or `Result` combinators whose names communicate the operation. Prefer a specific operation such as `map`, `filter_map`, `find`, `any`, `all`, `sum`, `collect`, or `partition` over a manual accumulator loop or generic `fold` when it fits.

Keep pipelines locally readable. Name meaningful intermediate values when a chain obscures domain intent, ownership, error types, or control flow. Preserve useful laziness, and do not add allocations, clones, or boxing merely to maintain a pipeline.

Use `match`, explicit loops, and local mutation when they make state transitions, side effects, borrowing, multiple accumulators, early exits, or measured hot paths clearer. Do not hide imperative work inside closures or force combinators when they increase nesting or make error handling less direct. Make a consequential reason for the imperative design evident in the code or explanation.
