# OHC Template Repo

Template repository for C++ projects using the OHC baseline conventions.

This template intentionally reuses core governance and style assets from `inheritance-chess-main`:

- `.clang-format`
- `.gitignore`
- `.editorconfig`
- `CODE_OF_CONDUCT.md`
- `LICENSE`
- `Doxyfile`
- `SECURITY.md`
- `CONTRIBUTING.md`
- `.github/CODEOWNERS`
- `.github/pull_request_template.md`
- `build_and_run_project.cmake`
- `cmakehelpers/detect_generator.cmake`

## Goals

- Fast bootstrap for new C++ repositories
- Consistent coding style and collaboration standards
- Ready-to-run local build/test flow
- CI baseline for multi-platform validation

## Template Version

- Version: `v1.1.0`
- Last updated: `2026-08-02`
- Change policy: updates should be additive and backward-compatible when possible

## Quick Start

Canonical build method:

```powershell
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

Canonical CI method:

```powershell
cmake --preset ci
cmake --build --preset ci-build
ctest --preset ci-test --output-on-failure
```

```powershell
cmake -DBUILD_TESTS=ON -P build_and_run_project.cmake
```

Or standard CMake commands:

```powershell
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
```

## Template Layout

```
ohc-template-repo/
  .gitignore
  .editorconfig
  .github/
    workflows/ci.yml
    ISSUE_TEMPLATE/
  cmakehelpers/
    detect_generator.cmake
  docs/
    portfolio_alignment_plan.md
    release_checklist.md
  include/
    template_module.hpp
  src/
    template_module.cpp
  tests/
    CMakeLists.txt
    test_main.cpp
    test_template_module.cpp
  CMakeLists.txt
  Doxyfile
  build_and_run_project.cmake
  main.cpp
```

## Reuse Checklist

When creating a new repo from this template:

1. Rename project metadata in `CMakeLists.txt` and `Doxyfile`.
2. Update `CODEOWNERS` and `CONTRIBUTING.md` contact references.
3. Keep `.gitignore` unless your language/tooling scope requires additional patterns.
4. Replace sample module in `include/`, `src/`, and `tests/`.
5. Keep formatting/governance files unless policy changes are intentional.
6. Review `SECURITY.md` and issue templates before publishing a public repository.
