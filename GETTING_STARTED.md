# Getting Started with OHC C++ Template

This guide will get you from zero to a working, personalized C++ project in
**under 5 minutes**.

This template is designed for a single project per repository. Keep one product,
one primary executable, and one clear source tree unless you intentionally move
beyond this template’s default scope.

---

## TL;DR - 30 Second Start

```bash
# 1. Clone the template
git clone https://github.com/your-org/ohc-template-repo.git my-new-project
cd my-new-project

# 2. Personalize it (Windows PowerShell)
.\scripts\rename-template.ps1 \
  -ProjectName "MyProject" \
  -Author "Your Name" \
  -Email "you@example.com" \
  -GitHubOwner "your-username"

# 3. Build & test
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

> **Linux/macOS?** Use `./scripts/rename-template.sh` instead.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Personalize the Template](#personalize-the-template)
3. [Local Development Workflows](#local-development-workflows)
4. [IDE Setup](#ide-setup)
5. [Understanding the CI Pipeline](#understanding-ci-pipeline)
6. [Common Tasks](#common-tasks)
7. [Template Structure Overview](#template-structure-overview)

---

## Prerequisites

See [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md) for detailed
installation instructions by platform.

**Quick summary**: You need CMake 3.25+, Ninja, Git, and a C++17
compiler. All optional tools (clang-format, clang-tidy,
Doxygen) are recommended but not required.

### Fastest Setup: Dev Container (Recommended)

**No local installation needed!** Open in VS Code with the
**Dev Containers** extension:

1. Install [Docker Desktop](
   https://www.docker.com/products/docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/) and the
   [Dev Containers extension](
   https://marketplace.visualstudio.com/items?
   itemName=ms-vscode-remote.remote-containers)
3. Open this folder in VS Code → **Reopen in Container**

The container includes CMake 3.28, Ninja, Clang 18, GCC 13,
Doxygen, cppcheck, valgrind, lcov, pre-commit, and VS Code
C++ extensions.

---

## Personalize the Template

Run the rename script **once** after cloning to make this
template yours.

### Windows (PowerShell)

```powershell
.\scripts\rename-template.ps1 `
  -ProjectName "MyProject" `
  -Author "Your Name" `
  -Email "you@example.com" `
  -GitHubOwner "your-github-username"
```

### Linux/macOS (Bash)

```bash
chmod +x scripts/rename-template.sh

./scripts/rename-template.sh MyProject \
  -a "Your Name" \
  -e "you@example.com" \
  -g "your-github-username"
```

### Preview Changes (Dry Run)

See what will be renamed without modifying files:

```bash
./scripts/rename-template.sh MyProject --dry-run -y
```

### After Renaming

```bash
git add -A
git commit -m "chore: personalize template for MyProject"
git remote set-url origin YOUR_NEW_REPO_URL
git push -u origin main
```

See the rename scripts for all available options.

---

## Local Development Workflows

Use **CMake presets** for standard development workflows:

```bash
# Daily development (Debug)
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure

# Release build (optimized)
cmake --preset ci
cmake --build --preset ci-build
ctest --preset ci-test --output-on-failure
```

List all available presets:
```bash
cmake --list-presets
```

For detailed configuration options, CMake generators, sanitizers,
coverage analysis, and more, see
[docs/CMAKE_CONFIGURATION.md](docs/CMAKE_CONFIGURATION.md).

### Pre-commit Git Hooks (Recommended)

Set up automatic code quality checks on commit:

```bash
# Install pre-commit
pip install pre-commit

# Install repository hooks
pre-commit install --install-hooks

# Run all hooks manually
pre-commit run --all-files

# Run single hook
pre-commit run clang-format --all-files
```

For troubleshooting pre-commit, see
[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

---

## IDE Setup

### VS Code (Recommended)

**With Dev Container** (easiest): Open folder and choose
**Reopen in Container** from the command palette.

**Without Dev Container**: Install these extensions:
- C/C++ Extension Pack
- CMake Tools
- Doxygen Documentation Generator

Settings in `.vscode/settings.json` are pre-configured for
format on save and test integration.

### Other IDEs

- **CLion/IntelliJ**: Open folder as CMake project; auto-detects
  CMakePresets.json
- **Visual Studio 2022**: Open CMakeLists.txt as project
- **Neovim/Vim**: Use cmake-tools.nvim or nvim-cmake

---

## Understanding CI Pipeline

The `.github/workflows/ci.yml` runs 7 jobs on every push and PR:

- **pre-commit**: Repository hooks (formatting, linting)
- **build-test**: Multi-platform build matrix (5 compiler
  combinations)
- **static-analysis**: clang-tidy and cppcheck
- **format-check**: Code formatting verification
- **security**: Trivy vulnerability scan
- **docs**: Doxygen build
- **release**: Creates releases on version tags

Tests run on Linux (GCC/Clang), Windows (MSVC/MinGW), and
macOS (Clang).

View results in GitHub Actions tab or PR checks.

For more details, see
[.github/workflows/ci.yml](.github/workflows/ci.yml).

---

## Common Tasks

### Add Source Files

1. Create `include/myproject/new_module.hpp`
2. Create `src/new_module.cpp`
3. Update `CMakeLists.txt` to include the new file
4. Rebuild: `cmake --build --preset dev-build`

### Add Tests

1. Create `tests/unit/test_new_module.cpp`
2. Write test functions with `TEST(SuiteName, TestName)`
3. CMake auto-discovers tests; rebuild to run
4. Run: `ctest --preset dev-test --output-on-failure`

See [docs/TESTING.md](docs/TESTING.md) for detailed testing guide.

### Enable Advanced Features

- **Sanitizers** (memory errors): See
  [docs/CMAKE_OPTIONS.md](docs/CMAKE_OPTIONS.md#enable_sanitizers)
- **Code coverage**: See
  [docs/CMAKE_OPTIONS.md](docs/CMAKE_OPTIONS.md#enable_coverage)
- **Documentation**: See
  [docs/CMAKE_OPTIONS.md](docs/CMAKE_OPTIONS.md#build_docs)

### Format Code

```bash
clang-format -i src/*.cpp include/*.hpp tests/*.cpp
```

Or use pre-commit to auto-fix:
```bash
pre-commit run clang-format --all-files
```

## Documentation

See the full documentation suite in `docs/`:

- [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md) — Installation
  by platform
- [docs/CMAKE_CONFIGURATION.md](
  docs/CMAKE_CONFIGURATION.md) — CMake workflows and generators
- [docs/CMAKE_OPTIONS.md](docs/CMAKE_OPTIONS.md) — All CMake
  configuration options
- [docs/TESTING.md](docs/TESTING.md) — Writing and running
  tests
- [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) — Common
  issues and solutions
- [docs/PACKAGING.md](docs/PACKAGING.md) — Distribution and
  consumption
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — Project design
  and layering
- [docs/NAMING_CONVENTIONS.md](docs/NAMING_CONVENTIONS.md) —
  Naming rules
- [docs/README.md](docs/README.md) — Documentation hub

---

## Template Structure Overview

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
```text

### Community Health Files

This template uses **default community health files** from the organization's
`.github` repository:

- **CODE_OF_CONDUCT.md** — Community standards (inherited from org)
- **CONTRIBUTING.md** — Contribution guidelines (inherited from org)
- **SECURITY.md** — Security policy (inherited from org)
- **SUPPORT.md** — Support and help resources (inherited from org)
- **ISSUE_TEMPLATE/** — Issue templates (inherited from org)

These files are automatically available to all repositories in the Obsidian
Honor Coders organization. Repositories may override these with project-specific
versions if needed.
```text
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
```text

---

## Next Steps

1. **Personalize** → run the rename script.
2. **Develop** → use `cmake --preset dev`.
3. **Push** → CI runs automatically.
4. **Release** → tag `v0.1.0` for automated release notes.

---

## Need Help?

- **Template docs**: see [docs/README.md](docs/README.md)
- **CMake Issues**: see the [CMake docs](https://cmake.org/documentation/)
- **CI Issues**: check the GitHub Actions logs
- **General**: open an issue in the template repository

---

## Happy coding! 🚀
