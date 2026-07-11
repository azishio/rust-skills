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
    git -C skills/write-idiomatic-rust/references/rust-api-guidelines sparse-checkout set --no-cone /src/ /LICENSE-APACHE /LICENSE-MIT
    git -C skills/write-idiomatic-rust/references/rust-design-patterns sparse-checkout set --no-cone /src/ /LICENSE
    git -C skills/write-idiomatic-rust/references/microsoft-rust-guidelines sparse-checkout set --no-cone /src/ /LICENSE.md

# Advance the tracked upstream branches. Commit the resulting gitlink changes
# in the parent repository after reviewing them.
update-references:
    git submodule update --remote --checkout skills/write-idiomatic-rust/references/rust-api-guidelines skills/write-idiomatic-rust/references/rust-design-patterns skills/write-idiomatic-rust/references/microsoft-rust-guidelines
    just sparse-references

# Clone a complete skill into a temporary directory, initialize its reference
# submodules, then copy the material without Git metadata into the user skill
# directory. Pass an installation root to override ~/.agents/skills.
install-user-skill install_dir='':
    #!/usr/bin/env bash
    set -euo pipefail
    install_root='{{ install_dir }}'
    if [[ -z "$install_root" ]]; then install_root="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"; fi
    skill_name=write-idiomatic-rust
    destination="$install_root/$skill_name"
    if [[ -e "$destination" ]]; then echo "Skill already exists: $destination" >&2; exit 1; fi
    temporary_repo="$(mktemp -d "${TMPDIR:-/tmp}/rust-skills.XXXXXX")"
    trap 'rm -rf "$temporary_repo"' EXIT
    git clone --recurse-submodules https://github.com/azishio/rust-skills.git "$temporary_repo"
    (cd "$temporary_repo" && just setup)
    source="$temporary_repo/skills/$skill_name"
    mkdir -p "$destination/references"
    cp -a "$source/SKILL.md" "$destination/"
    for directory in agents assets scripts; do if [[ -d "$source/$directory" ]]; then cp -a "$source/$directory" "$destination/"; fi; done
    for reference in "$source/references"/*; do name="$(basename "$reference")"; mkdir -p "$destination/references/$name"; cp -a "$reference"/* "$destination/references/$name/"; done
