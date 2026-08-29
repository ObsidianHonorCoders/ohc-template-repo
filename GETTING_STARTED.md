# Getting Started with OHC C++ Template

This guide will get you from zero to a working, personalized C++ project in **under 5 minutes**.

---

## TL;DR - 30 Second Start

```bash
# 1. Clone the template
git clone https://github.com/your-org/ohc-template-repo.git my-new-project
cd my-new-project

# 2. Personalize it (Windows PowerShell)
.\scripts\rename-template.ps1 -ProjectName "MyProject" -Author "Your Name" -Email "you@example.com" -GitHubOwner "your-username"

# 3. Build & test
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

> **Linux/macOS?** Use `./scripts/rename-template.sh` instead (same flags).

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
|------|-----------------|-----------------|
| **CMake** | 3.25+ | `winget install Kitware.CMake` / `apt install cmake` / `brew install cmake` |
| **Ninja** | 1.10+ | `winget install Ninja-build.Ninja` / `apt install ninja-build` / `brew install ninja` |
| **C++ Compiler** | C++17 support | See platform notes below |
| **Git** | 2.30+ | Standard install |

### Platform-Specific Compiler Recommendations

| Platform | Recommended | Alternative |
|----------|-------------|-------------|
| **Windows** | Visual Studio 2022 (MSVC) | MinGW-w64 (GCC), LLVM/Clang |
| **Linux** | GCC 11+ or Clang 14+ | Any recent compiler |
| **macOS** | Xcode Command Line Tools (Clang) | Homebrew GCC |

### Optional but Recommended
| Tool | Purpose | Install |
|------|---------|---------|
| **clang-format** | Code formatting | Bundled with LLVM |
| **clang-tidy** | Static analysis | Bundled with LLVM |
| **Doxygen** | Documentation generation | `apt install doxygen` / `brew install doxygen` |
| **pre-commit** | Git hooks | `pip install pre-commit` |
| **cppcheck** | Additional static analysis | `apt install cppcheck` / `brew install cppcheck` |

### Fastest Setup: Dev Container (Recommended)

**No local installation needed!** Open in VS Code with the **Dev Containers** extension:

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/) + [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Open this folder in VS Code → **"Reopen in Container"**

The container includes: CMake 3.28, Ninja, Clang 18, GCC 13, Doxygen, cppcheck, valgrind, lcov, pre-commit, and all VS Code C++ extensions pre-configured.

---

## Personalize the Template

Run the rename script **once** after cloning to make this template yours.

### Windows (PowerShell)

```powershell
# Required parameters
.\scripts\rename-template.ps1 -ProjectName "MyProject" -Author "Your Name" -Email "you@example.com" -GitHubOwner "your-github-username"

# Optional parameters
.\scripts\rename-template.ps1 -ProjectName "MyProject" `
  -Author "Your Name" `
  -Email "you@example.com" `
  -GitHubOwner "your-github-username" `
  -Description "My awesome C++ project" `
  -License "MIT" `
  -Version "0.1.0" `
  -Namespace "myproject" `
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
|-------------|---------------|----------------|
| `ohc-template-repo` | Your project name | 30+ files |
| `template_module` | Your module name (snake_case) | Source files, CMake, tests |
| `TemplateModule` | Your class name (PascalCase) | Headers, source |
| `TEMPLATE_MODULE` | Your macro guard (UPPER_SNAKE) | Headers |
| `template_module_app` | Your executable name | CMake, build scripts |
| `template_module_tests` | Your test executable name | CMake, CI |
| `calileus` | Your GitHub owner | CI, docs, scripts |
| `Calileus` | Your author name | License, docs, CMake |
| `calileus@example.com` | Your email | CMake, docs |

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

The template provides **CMake presets** for common scenarios. List them:

```bash
cmake --list-presets
```

| Preset | Use Case | Command |
|--------|----------|---------|
| `dev` | Daily development (Debug, tests on) | `cmake --preset dev` |
| `dev-build` | Build only | `cmake --build --preset dev-build` |
| `dev-test` | Run tests only | `ctest --preset dev-test` |
| `release` | Optimized Release build | `cmake --preset release` |
| `coverage` | Code coverage (gcov/lcov) | `cmake --preset coverage` |
| `sanitize-address` | AddressSanitizer | `cmake --preset sanitize-address` |
| `sanitize-thread` | ThreadSanitizer | `cmake --preset sanitize-thread` |
| `ci` | CI-equivalent build | `cmake --preset ci` |

### Quick Commands Cheat Sheet

```bash
# ── Daily Development ────────────────────────────────────────
cmake --preset dev                    # Configure (Debug, tests ON)
cmake --build --preset dev-build      # Build (parallel, all cores)
ctest --preset dev-test --output-on-failure  # Run tests with output

# ── One-liner (configure + build + test) ─────────────────────
cmake --preset dev && cmake --build --preset dev-build && ctest --preset dev-test

# ── Release Build ────────────────────────────────────────────
cmake --preset release
cmake --build --preset release-build
ctest --preset release-test

# ── Code Coverage ────────────────────────────────────────────
cmake --preset coverage
cmake --build --preset coverage-build
ctest --preset coverage-test
# Coverage report: build-coverage/coverage/index.html

# ── Sanitizers ───────────────────────────────────────────────
cmake --preset sanitize-address
cmake --build --preset sanitize-address-build
ctest --preset sanitize-address-test

# ── Documentation ────────────────────────────────────────────
cmake --preset docs
cmake --build --preset docs-build
# Output: build-docs/docs/html/index.html

# ── Static Analysis (local) ──────────────────────────────────
# Requires clang-tidy and cppcheck installed
cmake --preset dev
cmake --build --preset dev-build --target clang-tidy  # if configured
cppcheck --enable=all --std=c++17 --suppress=missingIncludeSystem src/ include/
```

### Standalone Build Script

For quick one-off builds without presets:

```bash
# Default (Release, with tests)
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

**With Dev Container:** Just open the folder → "Reopen in Container" → everything works.

**Without Dev Container:** Install these extensions:
- **C/C++ Extension Pack** (Microsoft)
- **CMake Tools** (Microsoft)
- **clang-format** (xaver.clang-format)
- **Doxygen Documentation Generator** (cschlosser.doxdocgen)

**Settings (`.vscode/settings.json`)** are pre-configured for:
- Format on save with clang-format
- CMake configure on folder open
- Test explorer integration

### CLion / IntelliJ

1. Open folder as CMake project
2. CLion auto-detects `CMakePresets.json`
3. Select preset: **dev** (Debug) or **release** (Release)
4. Run configurations auto-created for tests

### Visual Studio 2022

1. Open `CMakeLists.txt` → **CMake Project**
2. Select configuration: **dev** (Debug) or **release** (Release)
3. Build → **Build All** (Ctrl+Shift+B)
4. Test → **Test Explorer**

### Neovim / Vim

Use **cmake-tools.nvim** or **nvim-cmake** plugin. Presets work natively.

---

## Understanding the CI Pipeline

The `.github/workflows/ci.yml` runs **7 parallel jobs** on every push/PR:

| Job | Purpose | Triggers |
|-----|---------|----------|
| **pre-commit** | Runs all pre-commit hooks | Every push/PR |
| **build-test** | 8-config matrix build + test | Every push/PR |
| **static-analysis** | clang-tidy + cppcheck | Every push/PR |
| **format-check** | clang-format --dry-run --Werror | Every push/PR |
| **security** | Trivy vulnerability scan (SARIF) | Weekly + push/PR |
| **docs** | Doxygen build verification | Every push/PR |
| **release** | Auto-release on version tag | Tag push (v*) |

### Build Matrix (8 Configurations)

| OS | Compiler | Build Type |
|----|----------|------------|
| Ubuntu Latest | GCC 13 | Debug, Release |
| Ubuntu Latest | Clang 18 | Debug, Release |
| Windows Latest | MSVC (VS 2022) | Debug, Release |
| Windows Latest | MinGW (GCC) | Release |
| macOS Latest | Clang (Xcode) | Debug, Release |

### Viewing CI Results

- **GitHub Actions tab** → Select workflow run
- **Security tab** → Code scanning alerts (from Trivy + clang-tidy)
- **Checks** on PR → All 7 jobs must pass

---

## Common Tasks

### Add a New Source File

1. Create `include/myproject/new_module.hpp`
2. Create `src/new_module.cpp`
3. Add to `CMakeLists.txt`:
   ```cmake
   target_sources(myproject_lib PRIVATE src/new_module.cpp)
   ```
4. Run `cmake --build --preset dev-build`

### Add a New Test

1. Create `tests/test_new_module.cpp`
2. Add to `tests/CMakeLists.txt`:
   ```cmake
   add_test(NAME new_module COMMAND myproject_tests)
   ```
   Or use `gtest_discover_tests()` (already configured)

### Enable Sanitizers Locally

```bash
# AddressSanitizer (memory errors)
cmake --preset sanitize-address
cmake --build --preset sanitize-address-build
ctest --preset sanitize-address-test

# ThreadSanitizer (data races)
cmake --preset sanitize-thread
cmake --build --preset sanitize-thread-build
ctest --preset sanitize-thread-test

# Both (if supported)
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

# GitHub Actions (Dependabot handles this automatically)
# Check .github/dependabot.yml for schedule

# CMake/CPM dependencies - update versions in CMakeLists.txt
```

### Format Code

```bash
# Format all files
clang-format -i src/*.cpp include/*.hpp tests/*.cpp main.cpp

# Check only (CI does this)
clang-format --dry-run --Werror src/*.cpp include/*.hpp tests/*.cpp main.cpp
```

### Run Static Analysis

```bash
# clang-tidy (requires compile_commands.json from CMake)
cmake --preset dev
run-clang-tidy.py -p build-dev

# cppcheck
cppcheck --enable=all --std=c++17 --suppress=missingIncludeSystem \
         --inline-suppr src/ include/ tests/
```

---

## Troubleshooting

### "CMake could not find compiler"

```bash
# Windows: Install Visual Studio Build Tools or MinGW
# Linux: sudo apt install build-essential
# macOS: xcode-select --install

# Verify compiler in PATH
gcc --version
clang --version
cl --version  # Windows MSVC
```

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
cmake --preset dev  # Has -DBUILD_TESTING=ON

# Check test discovery
ctest --preset dev-test -N  # List tests without running

# Verify test executable exists
ls build-dev/tests/
```

### "clang-format not found"

```bash
# Install LLVM toolchain
# Windows: winget install LLVM.LLVM
# Linux: apt install clang-format
# macOS: brew install llvm (then link: ln -s /opt/homebrew/opt/llvm/bin/clang-format /usr/local/bin/)
```

### "Pre-commit hooks fail"

```bash
# Install hooks
pre-commit install

# Run manually to see errors
pre-commit run --all-files

# Auto-fix formatting
pre-commit run clang-format --all-files

# Update hook versions
pre-commit autoupdate
```

### "Dev Container won't start"

1. Ensure Docker Desktop is running
2. Check `.devcontainer/devcontainer.json` syntax
3. Try: **Dev Containers: Rebuild Container** (no cache)
4. Check VS Code output → "Dev Containers" log

### CI Fails Locally But Passes (or Vice Versa)

| Issue | Fix |
|-------|-----|
| Line endings | Ensure `.editorconfig` has `end_of_line = lf` and Git is configured: `git config --global core.autocrlf input` |
| Compiler version | Match CI: GCC 13 / Clang 18 / MSVC 19.40 |
| Missing deps | CI installs everything; locally use dev container |

---

## Template Structure Overview

```
ohc-template-repo/
├── .devcontainer/           # Dev Container config (VS Code)
│   ├── devcontainer.json    # Container definition
│   └── setup.sh             # Post-create setup script
├── .github/
│   ├── workflows/
│   │   ├── ci.yml           # Main CI pipeline (7 jobs)
│   │   └── release.yml      # Automated releases
│   └── dependabot.yml       # Auto-dependency updates
├── cmakehelpers/
│   └── detect_generator.cmake  # Auto-detect generator (legacy script)
├── docs/
│   └── release_checklist.md # Release process checklist
├── include/
│   └── myproject/           # Public headers (after rename)
│       └── my_module.hpp
├── src/
│   └── my_module.cpp        # Private implementation
├── tests/
│   ├── CMakeLists.txt       # GoogleTest + gtest_discover_tests
│   └── test_my_module.cpp   # Unit tests
├── scripts/
│   ├── rename-template.ps1  # Windows rename script
│   └── rename-template.sh   # Linux/macOS rename script
├── .clang-format            # Code style (Allman, 2-space, 160col)
├── .editorconfig            # Editor settings
├── .gitignore               # Git ignore patterns
├── .pre-commit-config.yaml  # 10+ pre-commit hooks
├── build_and_run_project.cmake  # Standalone build script
├── CHANGELOG.md             # Keep a Changelog format
├── CMakeLists.txt           # Modern CMake (library + install)
├── CMakePresets.json        # 7 configure presets + build/test presets
├── CMakeUserPresets.json.example  # Extended presets for users
├── CODE_OF_CONDUCT.md       # Contributor Covenant
├── CONTRIBUTING.md          # Contribution guidelines
├── Doxyfile                 # Doxygen configuration
├── GETTING_STARTED.md       # This file
├── LICENSE                  # MIT License
├── main.cpp                 # Application entry point
├── NAMING_CONVENTIONS.md    # Naming standards reference
├── README.md                # Project overview
├── SECURITY.md              # Security policy
└── TEMPLATE_IMPROVEMENTS.md # History of template upgrades
```

---

## Next Steps

1. **Personalize** → Run the rename script
2. **Develop** → Use `cmake --preset dev` workflow
3. **Push** → CI runs automatically
4. **Release** → Tag `v0.1.0` → Automated release + changelog

---

## Need Help?

- **Template Issues**: Check [TEMPLATE_IMPROVEMENTS.md](TEMPLATE_IMPROVEMENTS.md) for known limitations
- **CMake Issues**: See [CMake Documentation](https://cmake.org/documentation/)
- **CI Issues**: Check GitHub Actions logs → Security tab for code scanning
- **General**: Open an issue in the template repository

---

*Happy coding! 🚀*