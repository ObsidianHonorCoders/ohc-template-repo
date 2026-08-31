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

# 2) preview a rename safely before applying it
bash ./scripts/rename-template.sh MyProject --dry-run -y

# 3) build and test
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

If a project wants a less strict warning policy, configure the template with:

```bash
cmake -S . -B build -DOHC_ENABLE_WERROR=OFF
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
[../GETTING_STARTED.md](../GETTING_STARTED.md).

## Core docs

- [../GETTING_STARTED.md](../GETTING_STARTED.md) — first-run workflow and
  troubleshooting
- [NAMING_CONVENTIONS.md](NAMING_CONVENTIONS.md) — naming rules and project
  cleanup guidance
- [CHANGELOG.md](CHANGELOG.md) — release history

## Repository layout

```text
.
├── .devcontainer/
│   ├── devcontainer.json
│   └── setup.sh
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE/
│   │   ├── default.md
│   │   └── release.md
│   ├── workflows/
│   │   ├── ci.yml
│   │   └── docs.yml
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
├── cmake/
│   └── ohc_template_repo-config.cmake.in
├── docs/
│   ├── CHANGELOG.md
│   ├── CODE_OF_CONDUCT.md
│   ├── CONTRIBUTING.md
│   ├── NAMING_CONVENTIONS.md
│   ├── README.md
│   ├── SECURITY.md
│   ├── release_checklist.md
│   └── DoxyPage/
│       ├── custom.css
│       └── OHC-logo-lowresolution.png
├── include/
│   └── template_module.hpp
├── scripts/
│   ├── rename-template.ps1
│   └── rename-template.sh
├── src/
│   └── template_module.cpp
├── tests/
│   ├── CMakeLists.txt
│   └── test_template_module.cpp
├── .clang-format
├── .editorconfig
├── .gitignore
├── .pre-commit-config.yaml
├── .secrets.baseline
├── CMakeLists.txt
├── CMakePresets.json
├── GETTING_STARTED.md
├── LICENSE
├── main.cpp
├── README.md
├── SECURITY.md
└── docs/
    ├── DoxyPage/
    │   ├── Doxyfile
    │   ├── custom.css
    │   └── OHC-logo-lowresolution.png
    ├── ...
```

## Template usage checklist

1. Run the rename script once from the repository root.
2. Replace the sample module with your real domain code.
3. Keep the standard governance files unless you intentionally customize them.
4. Validate locally with the dev preset before pushing.
5. Publish using the release PR template.

This repository is intentionally lean: the main onboarding path is short, the
build flow is standard, and the project rules are documented without extra
noise.
