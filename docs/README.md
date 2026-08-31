# OHC Template Repo

A simple, production-ready C++ starter template for libraries and small
applications.

## What is included

- Modern CMake with a library target and install/export support
- C++17 baseline with warnings enabled
- GoogleTest integration and CTest presets
- Cross-platform CI workflow for Linux, Windows, and macOS
- Pre-commit formatting and lint hooks
- Dev container support for fast onboarding
- Rename helper for adapting the template to a real project name

## Template status

- Version: v2.0.0
- Latest review: 2026-08-29
- Goal: complete, simple, and easy to personalize

## Quick start

```powershell
# 1) personalize the template
.\scripts\rename-template.ps1 -ProjectName "MyProject" -Author "Your Name" \
  -Email "you@example.com" -GitHubOwner "your-github-user"

# 2) build and test
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

### Local pre-commit checks

```bash
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install pre-commit
pre-commit install --install-hooks
pre-commit run --all-files
```

If a hook auto-fixes files (for example `cmake-format`), run the command again
to confirm the repo is clean.

For the full onboarding flow, see
[GETTING_STARTED.md](GETTING_STARTED.md).

## Core docs

- [GETTING_STARTED.md](GETTING_STARTED.md) — first-run workflow and
  troubleshooting
- [NAMING_CONVENTIONS.md](NAMING_CONVENTIONS.md) — naming rules and project
  cleanup guidance
- [CHANGELOG.md](CHANGELOG.md) — release history
- [docs/release_checklist.md](docs/release_checklist.md) — release checklist

## Repository layout

```text
.
├── .devcontainer/
├── .github/
├── cmake/
├── cmakehelpers/
├── docs/
├── include/
├── scripts/
├── src/
├── tests/
├── .clang-format
├── .editorconfig
├── .gitignore
├── .pre-commit-config.yaml
├── CMakeLists.txt
├── CMakePresets.json
├── CHANGELOG.md
├── GETTING_STARTED.md
├── LICENSE
├── main.cpp
├── NAMING_CONVENTIONS.md
├── README.md
├── SECURITY.md
├── build_and_run_project.cmake
└── Doxyfile
```

## Template usage checklist

1. Run the rename script once from the repository root.
2. Replace the sample module with your real domain code.
3. Keep the standard governance files unless you intentionally customize them.
4. Validate locally with the dev preset before pushing.
5. Publish using the release checklist in
   [docs/release_checklist.md](docs/release_checklist.md).

This repository is intentionally lean: the main onboarding path is short, the
build flow is standard, and the project rules are documented without extra
noise.
