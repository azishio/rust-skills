set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

# Initialize the revisions recorded by the parent repository, then retain only
# each upstream's src directory in the working tree.
setup:
    git submodule update --init --recursive
    just sparse-references

# Reapply the non-cone patterns after cloning or updating submodules.
sparse-references:
    git -C skills/write-idiomatic-rust/references/rust-api-guidelines sparse-checkout set --no-cone /src/
    git -C skills/write-idiomatic-rust/references/rust-design-patterns sparse-checkout set --no-cone /src/
    git -C skills/write-idiomatic-rust/references/microsoft-rust-guidelines sparse-checkout set --no-cone /src/

# Advance the tracked upstream branches. Commit the resulting gitlink changes
# in the parent repository after reviewing them.
update-references:
    git submodule update --remote --checkout skills/write-idiomatic-rust/references/rust-api-guidelines skills/write-idiomatic-rust/references/rust-design-patterns skills/write-idiomatic-rust/references/microsoft-rust-guidelines
    just sparse-references
