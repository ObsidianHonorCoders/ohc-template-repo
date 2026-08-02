# Contributing Guidelines

Thank you for contributing. This document defines the expected workflow and quality bar for changes in repositories based on this template.

## Getting Started

1. Fork the repository.
2. Create a branch from the target integration branch.
3. Implement one logical change per branch.
4. Add or update tests and documentation as needed.
5. Open a Pull Request using `.github/pull_request_template.md`.

## Branching Strategy

- `main`: stable production branch.
- `develop`: integration branch (default PR target for regular work).
- `feature/*`: new features.
- `fix/*`: bug fixes.
- `docs/*`: documentation-only updates.
- `chore/*`: build, CI, tooling, or maintenance.

Hotfixes may target `main` directly when necessary.

## Commit and PR Conventions

### Commit Messages

Use concise, imperative messages:

- `add input validation for config parser`
- `fix null pointer check in api handler`
- `update ci cache strategy`

### PR Titles

Use the format:

`<type>(scope): short imperative summary`

Types:

- `feat`
- `fix`
- `refactor`
- `perf`
- `docs`
- `test`
- `build`
- `chore`

### PR Content Requirements

Complete all sections from the PR template:

- Summary
- Type of change
- Scope
- Testing evidence
- Breaking changes and migration notes (if any)
- Final checklist

## Quality Standards

- Follow project formatting rules (`.clang-format`).
- Keep changes focused and reviewable.
- Avoid unrelated refactors in the same PR.
- Prefer clear naming and low-complexity implementations.

## Documentation Standards

- Document public APIs and non-obvious behavior.
- Use Doxygen-compatible comments where applicable.
- Update README, runbooks, or architecture docs when behavior changes.

## Testing Standards

- New features require tests.
- Bug fixes require regression coverage where practical.
- Run local verification before opening a PR.

Typical commands:

```bash
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build
ctest --test-dir build --output-on-failure
```

## Review and Merge Requirements

- At least one approval is required.
- Required CI checks must pass.
- No new warnings should be introduced.
- Merge strategy should follow repository policy (`squash` or `rebase`).

## Licensing

By contributing, you agree that your contributions are licensed under the project license declared in `LICENSE`.

## Questions

For clarification, open an issue or start a discussion with maintainers.
