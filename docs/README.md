# OHC Template Repo

A single-project C++ starter template intended for one application or library per
repository. It keeps the structure lean, explicit, and easy to customize without
implying a multi-project or monorepo layout.

## What is included

- Modern CMake with a library target and install/export support
- C++17 baseline with warnings enabled
- GoogleTest integration and CTest presets
- Cross-platform CI workflow for Linux, Windows, and macOS
- Pre-commit formatting and lint hooks
- Dev container support for fast onboarding
- Rename helper for adapting the template to a real project name

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

Install and run pre-commit hooks for code quality:

```bash
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install pre-commit
pre-commit install --install-hooks
pre-commit run --all-files
```

If a hook auto-fixes files (e.g., `cmake-format`), run the
command again to confirm the repo is clean.

See [GETTING_STARTED.md](../GETTING_STARTED.md) and
[TESTING.md](TESTING.md) for more details.

## Core docs

- [GETTING_STARTED.md](../GETTING_STARTED.md) — Quick start
  and first-run workflow
- [ARCHITECTURE.md](ARCHITECTURE.md) — Project architecture
  and design
- [DEPENDENCIES.md](DEPENDENCIES.md) — Installation by
  platform
- [CMAKE_CONFIGURATION.md](CMAKE_CONFIGURATION.md) — CMake
  workflows, presets, and generators
- [CMAKE_OPTIONS.md](CMAKE_OPTIONS.md) — All CMake options
  reference
- [TESTING.md](TESTING.md) — Writing and running tests with
  GoogleTest
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — Common issues
  and solutions
- [PACKAGING.md](PACKAGING.md) — Building, installing, and
  distributing packages
- [NAMING_CONVENTIONS.md](NAMING_CONVENTIONS.md) — Naming
  rules and cleanup guidance
- [CHANGELOG.md](CHANGELOG.md) — Release history
- [API Documentation (Doxygen)](
    https://obsidianhonorcoders.github.io/ohc-template-repo/
  ) — Generated API reference

## Community health files

This template uses default community health files from the organization `.github`
repository:

- **CODE_OF_CONDUCT.md** — Community standards and expectations
- **CONTRIBUTING.md** — Contribution guidelines and workflow
- **SECURITY.md** — Security reporting policy
- **SUPPORT.md** — Getting help and support
- **ISSUE_TEMPLATE/** — Issue and feature request templates

These are automatically inherited by all Obsidian Honor Coders repositories.
Projects may override them locally if project-specific policies are needed.

## Repository layout

```text
.
├── .devcontainer/
│   ├── devcontainer.json
│   └── setup.sh
├── .github/
│   ├── workflows/
│   │   ├── ci.yml
│   │   └── docs.yml
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
├── cmake/
│   └── ohc_template_repo-config.cmake.in
├── docs/
│   ├── DoxyPage/
│   │   ├── custom.css
│   │   ├── Doxyfile
│   │   └── OHC-logo-lowresolution.png
│   ├── ARCHITECTURE.md
│   ├── CHANGELOG.md
│   ├── NAMING_CONVENTIONS.md
│   └── README.md
├── include/
│   ├── architecture/
│   │   ├── acquisition.hpp
│   │   ├── output.hpp
│   │   └── processing.hpp
│   ├── common/
│   │   └── string_utils.hpp
│   └── compatibility_api.hpp
├── scripts/
│   ├── rename-template.ps1
│   └── rename-template.sh
├── src/
│   ├── app/
│   │   └── main.cpp
│   ├── architecture/
│   │   ├── acquisition.cpp
│   │   ├── output.cpp
│   │   └── processing.cpp
│   ├── common/
│   │   └── string_utils.cpp
│   └── compatibility_api.cpp
├── tests/
│   ├── integration/
│   │   └── test_pipeline.cpp
│   ├── unit/
│   │   └── test_template_module.cpp
│   └── CMakeLists.txt
├── .clang-format
├── .editorconfig
├── .gitattributes
├── .gitignore
├── .pre-commit-config.yaml
├── .secrets.baseline
├── CMakeLists.txt
├── CMakePresets.json
└── GETTING_STARTED.md
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
