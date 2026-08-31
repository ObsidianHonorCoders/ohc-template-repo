# Getting Started with OHC C++ Template

This guide will get you from zero to a working, personalized C++ project in
**under 5 minutes**.

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
5. [Understanding the CI Pipeline](#understanding-the-ci-pipeline)
6. [Common Tasks](#common-tasks)
7. [Troubleshooting](#troubleshooting)
8. [Template Structure Overview](#template-structure-overview)

---

## Prerequisites

### Required (All Platforms)

| Tool | Minimum Version | Install Command |
| ------ | ----------------- | ----------------- |
| **CMake** | 3.25+ | `apt install cmake` |
| **Ninja** | 1.10+ | `apt install ninja-build` |
| **C++ Compiler** | C++17 support | Platform notes below |
| **Git** | 2.30+ | Standard install |

### Platform-Specific Compiler Recommendations

| Platform | Recommended | Alternative |
| ---------- | ------------- | ------------- |
| **Windows** | Visual Studio 2022 | MinGW-w64 |
| **Linux** | GCC 11+ or Clang 14+ | Any recent compiler |
| **macOS** | Xcode Command Line Tools | Homebrew GCC |

### Optional but Recommended

| Tool | Purpose | Install |
| ------ | --------- | --------- |
| **clang-format** | Formatting | Bundled with LLVM |
| **clang-tidy** | Static analysis | Bundled with LLVM |
| **Doxygen** | Docs | `apt install doxygen` |
| **pre-commit** | Git hooks | `pip install pre-commit` |
| **cppcheck** | Extra analysis | `apt install cppcheck` |

### Fastest Setup: Dev Container (Recommended)

**No local installation needed!** Open in VS Code with the **Dev Containers**
extension:

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/) and the
   [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Open this folder in VS Code → **Reopen in Container**

The container includes CMake 3.28, Ninja, Clang 18, GCC 13, Doxygen,
cppcheck, valgrind, lcov, pre-commit, and the VS Code C++ extensions.

---

## Personalize the Template

Run the rename script **once** after cloning to make this template yours.

### Windows (PowerShell)

```powershell
# Required parameters
.\scripts\rename-template.ps1 \
  -ProjectName "MyProject" \
  -Author "Your Name" \
  -Email "you@example.com" \
  -GitHubOwner "your-github-username"

# Optional parameters
.\scripts\rename-template.ps1 \
  -ProjectName "MyProject" \
  -Author "Your Name" \
  -Email "you@example.com" \
  -GitHubOwner "your-github-username" \
  -Description "My awesome C++ project" \
  -License "MIT" \
  -Version "0.1.0" \
  -Namespace "myproject" \
  -ExecutableName "myapp"
```

### Linux/macOS (Bash)

```bash
# Make executable first
chmod +x scripts/rename-template.sh

# Required parameters
./scripts/rename-template.sh MyProject \
  -a "Your Name" \
  -e "you@example.com" \
  -g "your-github-username"

# Optional parameters
./scripts/rename-template.sh MyProject \
  -a "Your Name" \
  -e "you@example.com" \
  -g "your-github-username" \
  -d "My awesome C++ project" \
  -l "MIT" \
  -v "0.1.0" \
  -n "myproject" \
  -x "myapp"
```

### What Gets Renamed

| Placeholder | Replaced With | Files Affected |
| ------------- | --------------- | ---------------- |
| `ohc-template-repo` | Your project name | 30+ files |
| `template_module` | Your module name | Source files |
| `TemplateModule` | Your class name | Headers, source |
| `TEMPLATE_MODULE` | Macro guard | Headers |
| `template_module_app` | Executable name | CMake, scripts |
| `template_module_tests` | Test target name | CMake, CI |
| `calileus` | GitHub owner | CI, docs |
| `Calileus` | Author name | Docs, CMake |
| `calileus@example.com` | Email | Docs, CMake |

### After Renaming

```bash
# 1. Verify the changes
git diff --stat

# 2. Commit the personalized template
git add -A
git commit -m "chore: personalize template for MyProject"

# 3. Push to your new repository
git remote set-url origin https://github.com/your-username/my-new-project.git
git push -u origin main
```

---

## Local Development Workflows

### Preset-Based Workflows (Recommended)

The template provides **CMake presets** for common scenarios.

```bash
cmake --list-presets
```

The current repository ships with two configured presets:

| Preset | Use Case | Command |
| -------- | ---------- | --------- |
| `dev` | Debug work | `cmake --preset dev` |
| `dev-build` | Build only | `cmake --build --preset dev-build` |
| `dev-test` | Run tests only | `ctest --preset dev-test` |
| `ci` | Release-mode CI-equivalent build | `cmake --preset ci` |
| `ci-build` | Release build only | `cmake --build --preset ci-build` |
| `ci-test` | Release test run | `ctest --preset ci-test` |

The extra sanitizer and coverage presets mentioned in older template drafts are not defined in the current `CMakePresets.json` file.

### Quick Commands Cheat Sheet

```bash
# Daily development
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure

# One-liner
cmake --preset dev && cmake --build --preset dev-build && ctest --preset dev-test

# Release-mode CI-equivalent build
cmake --preset ci
cmake --build --preset ci-build
ctest --preset ci-test

# Optional local coverage/sanitizer configuration
# These are not shipped as presets in the current repository.
cmake -S . -B build-coverage -DENABLE_COVERAGE=ON -DBUILD_TESTING=ON
cmake --build build-coverage
ctest --test-dir build-coverage --output-on-failure

# Documentation build
cmake -S . -B build-docs -DBUILD_TESTING=OFF -DBUILD_DOCS=ON
cmake --build build-docs --target docs

# Static analysis
cmake --preset dev
cmake --build --preset dev-build --target clang-tidy
cppcheck --enable=all --std=c++17 --inline-suppr src/ include/
```

### Standalone Build Script

For quick one-off builds without presets:

```bash
# Default release build
cmake -P build_and_run_project.cmake

# Debug build
cmake -DCMAKE_BUILD_TYPE=Debug -P build_and_run_project.cmake

# Without tests
cmake -DBUILD_TESTS=OFF -P build_and_run_project.cmake

# Custom executable name
cmake -DEXE_NAME=myapp -P build_and_run_project.cmake
```

---

## IDE Setup

### VS Code (Recommended)

**With Dev Container:** open the folder and choose **Reopen in Container**.

**Without Dev Container:** install these extensions:

- **C/C++ Extension Pack**
- **CMake Tools**
- **clang-format**
- **Doxygen Documentation Generator**

**Settings** in `.vscode/settings.json` are pre-configured for:

- format on save
- CMake configure on folder open
- test explorer integration

### CLion / IntelliJ

1. Open the folder as a CMake project.
2. CLion auto-detects `CMakePresets.json`.
3. Select **dev** or **release**.
4. Run the generated test configurations.

### Visual Studio 2022

1. Open `CMakeLists.txt` as a CMake project.
2. Select **dev** or **release**.
3. Build → **Build All**.
4. Use **Test Explorer** to run tests.

### Neovim / Vim

Use **cmake-tools.nvim** or **nvim-cmake**.

---

## Understanding the CI Pipeline

The `.github/workflows/ci.yml` file runs **7 parallel jobs** on every push
and pull request.

| Job | Purpose | Triggers |
| ----- | --------- | ---------- |
| **pre-commit** | Runs repo hooks | Every push/PR |
| **build-test** | Matrix build and tests | Every push/PR |
| **static-analysis** | clang-tidy + cppcheck | Every push/PR |
| **format-check** | Format verification | Every push/PR |
| **security** | Trivy scan | Weekly + push/PR |
| **docs** | Doxygen build | Every push/PR |
| **release** | Versioned release | Tag push |

### Build Matrix

| OS | Compiler | Build Type |
| ---- | ---------- | ------------ |
| Ubuntu Latest | GCC 13 | Debug, Release |
| Ubuntu Latest | Clang 18 | Debug, Release |
| Windows Latest | MSVC | Debug, Release |
| Windows Latest | MinGW | Release |
| macOS Latest | Clang | Debug, Release |

### Viewing CI Results

- GitHub Actions → select the workflow run
- Security tab → code scanning alerts
- PR checks → verify all required jobs pass

---

## Common Tasks

### Add a New Source File

1. Create `include/myproject/new_module.hpp`.
2. Create `src/new_module.cpp`.
3. Add it in `CMakeLists.txt`:

   ```cmake
   target_sources(myproject_lib PRIVATE src/new_module.cpp)
   ```

4. Run `cmake --build --preset dev-build`.

### Add a New Test

1. Create `tests/test_new_module.cpp`.
2. Add it to `tests/CMakeLists.txt`.

   ```cmake
   add_test(NAME new_module COMMAND myproject_tests)
   ```

   Or use `gtest_discover_tests()`.

### Enable Sanitizers Locally

```bash
# AddressSanitizer
cmake --preset sanitize-address
cmake --build --preset sanitize-address-build
ctest --preset sanitize-address-test

# ThreadSanitizer
cmake --preset sanitize-thread
cmake --build --preset sanitize-thread-build
ctest --preset sanitize-thread-test

# Both, if supported
cmake -DCMAKE_CXX_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer" \
  -DCMAKE_C_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer" \
  -DCMAKE_BUILD_TYPE=Debug \
  -B build-sanitize
```

### Generate Code Coverage

```bash
cmake --preset coverage
cmake --build --preset coverage-build
ctest --preset coverage-test
# Open: build-coverage/coverage/index.html
```

### Update Dependencies

```bash
# Pre-commit hooks
pre-commit autoupdate

# GitHub Actions
# Check .github/dependabot.yml for the schedule
```

### Format Code

```bash
# Format all files
clang-format -i src/*.cpp include/*.hpp tests/*.cpp main.cpp

# Check only
clang-format --dry-run --Werror src/*.cpp include/*.hpp tests/*.cpp main.cpp
```

### Run Static Analysis

```bash
# clang-tidy
cmake --preset dev
run-clang-tidy.py -p build-dev

# cppcheck
cppcheck --enable=all --std=c++17 --inline-suppr src/ include/ tests/
```

### Run pre-commit locally

```bash
# Create an isolated environment so pip is not blocked by Debian/Ubuntu PEP 668 rules
python3 -m venv .venv
. .venv/bin/activate

# Install the tool in that environment
python -m pip install --upgrade pip
python -m pip install pre-commit

# Install repo hooks so they run automatically on commit
pre-commit install --install-hooks

# Run the full hook set on demand
pre-commit run --all-files

# If a hook auto-fixes files, run it again to confirm the repo is clean
pre-commit run --all-files

# Run a single hook, for example format checks
pre-commit run clang-format --all-files
```

> On Ubuntu/Debian, `python3 -m pip install --user pre-commit` can fail because
> the system Python is managed by PEP 668. A local virtual environment avoids
> that problem.

---

## Troubleshooting

### "CMake could not find compiler"

```bash
# Windows: install Visual Studio Build Tools or MinGW
# Linux: sudo apt install build-essential
# macOS: xcode-select --install

gcc --version
clang --version
cl --version  # Windows MSVC
```

This repository currently requires CMake 3.25+ and a C++17 compiler, as defined in `CMakeLists.txt`.

### "Ninja not found"

```bash
# Windows
winget install Ninja-build.Ninja

# Linux
sudo apt install ninja-build

# macOS
brew install ninja
```

### "Tests not found / not running"

```bash
# Ensure tests are enabled in CMake
cmake --preset dev  # sets BUILD_TESTING=ON

# Check test discovery
ctest --preset dev-test -N

# Verify test executable exists
ls build/dev/tests/
```

### "clang-format not found"

```bash
# Install LLVM toolchain
# Windows: winget install LLVM.LLVM
# Linux: apt install clang-format
# macOS: brew install llvm
```

### "Pre-commit hooks fail"

```bash
# Install hooks
pre-commit install

# Run manually
pre-commit run --all-files

# Auto-fix formatting
pre-commit run clang-format --all-files

# Update hook versions
pre-commit autoupdate
```

### "Dev Container won't start"

1. Ensure Docker Desktop is running.
2. Check `.devcontainer/devcontainer.json` syntax.
3. Try **Dev Containers: Rebuild Container**.
4. Check the VS Code output for the Dev Containers log.

The repository does include a `.devcontainer/` folder, but the actual setup is driven by the contents of that directory rather than a separate top-level container guide.

### CI Fails Locally But Passes (or Vice Versa)

| Issue | Fix |
| ------- | ----- |
| Line endings | Use `end_of_line = lf` in `.editorconfig` |
| Compiler version | Match CI: GCC 13 / Clang 18 / MSVC 19.40 |
| Missing deps | Use the dev container or install the same tools |

---

## Template Structure Overview

```text
ohc-template-repo/
├── .devcontainer/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   │   ├── ci.yml
│   │   └── docs.yml
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
├── cmake/
├── cmakehelpers/
├── docs/
│   ├── CHANGELOG.md
│   ├── CODE_OF_CONDUCT.md
│   ├── CONTRIBUTING.md
│   ├── NAMING_CONVENTIONS.md
│   ├── README.md
│   ├── SECURITY.md
│   ├── release_checklist.md
│   └── DoxyPage/
├── include/
│   └── template_module.hpp
├── src/
│   └── template_module.cpp
├── tests/
│   ├── CMakeLists.txt
│   └── test_template_module.cpp
├── scripts/
│   ├── rename-template.ps1
│   └── rename-template.sh
├── .clang-format
├── .editorconfig
├── .gitignore
├── .pre-commit-config.yaml
├── build_and_run_project.cmake
├── CMakeLists.txt
├── CMakePresets.json
├── Doxyfile
├── GETTING_STARTED.md
├── LICENSE
├── main.cpp
└── .secrets.baseline
```

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
