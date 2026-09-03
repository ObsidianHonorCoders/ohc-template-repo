# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2026-09-02

### Added in v2.1.0

- **New architecture documentation** (`docs/ARCHITECTURE.md`) — complete
  architecture guide covering layering model, public interface, domain layer,
  shared utilities, application entry point, and test layer
- **New documentation index** (`docs/README.md`) — centralized documentation
  hub with template status, quick start, core docs links, repository layout,
  and usage checklist
- **New template rename scripts** (`scripts/rename-template.ps1`,
  `scripts/rename-template.sh`) — comprehensive PowerShell and Bash scripts for
  personalizing the template with project name, namespace, author, GitHub
  owner, and automatic snake_case/kebab-case derivation; includes dry-run mode
- **New CMake presets** (`CMakePresets.json`) — developer Debug (`dev`) and CI
  Release (`ci`) configure/build/test presets with consistent binary
  directories
- **New GitHub Actions CI workflow** (`.github/workflows/ci.yml`) — complete
  rewrite with: pre-commit checks job; multi-platform build matrix (Linux
  GCC/Clang, Windows MSVC/MinGW, macOS Clang); static analysis (clang-tidy,
  cppcheck); format check (clang-format); security scanning (Trivy); docs
  build; and automated release on tags
- **New GitHub Actions docs workflow** (`.github/workflows/docs.yml`) —
  dedicated documentation build and deployment to GitHub Pages
- **New governance and community files**: `.github/CODEOWNERS`,
  `.github/dependabot.yml`, `.github/ISSUE_TEMPLATE/bug_report.md`,
  `.github/ISSUE_TEMPLATE/feature_request.md`,
  `.github/ISSUE_TEMPLATE/config.yml`,
  `.github/PULL_REQUEST_TEMPLATE/default.md`,
  `.github/PULL_REQUEST_TEMPLATE/release.md`,
  `.github/pull_request_template.md`
- **New dev container support** (`.devcontainer/devcontainer.json`,
  `.devcontainer/setup.sh`) — full development environment with CMake,
  ninja, clang, clang-format, cppcheck, pre-commit, Doxygen, GraphViz
- **New pre-commit configuration** (`.pre-commit-config.yaml`) — hooks for
  clang-format, cmake-format, trailing whitespace, end-of-file, large files,
  merge conflicts, and more
- **New secrets baseline** (`.secrets.baseline`) — pre-commit secret
  detection baseline
- **New Doxygen customization** (`docs/DoxyPage/custom.css`,
  `docs/DoxyPage/OHC-logo-lowresolution.png`) — custom styling and logo for
  generated API docs
- **New Doxyfile location** (`docs/DoxyPage/Doxyfile`) — moved from root to
  dedicated docs subfolder
- **New `.gitattributes`** — explicit line ending and diff rules for C++
  sources, CMake, and markdown
- **New `.editorconfig`** — cross-editor coding style consistency
- **New `cmake/ohc_template_repo-config.cmake.in`** — config package
  template for downstream consumers
- **New domain layer modules**: `include/architecture/acquisition.hpp`,
  `include/architecture/processing.hpp`, `include/architecture/output.hpp`,
  `src/architecture/acquisition.cpp`, `src/architecture/processing.cpp`,
  `src/architecture/output.cpp` — three-module pipeline (acquire → process →
  output) replacing the monolithic template module
- **New shared utility**: `include/common/string_utils.hpp`,
  `src/common/string_utils.cpp` — string manipulation helpers
- **New compatibility API**: `include/compatibility_api.hpp`,
  `src/compatibility_api.cpp` — platform abstraction layer
- **New application entry point**: `src/app/main.cpp` — thin orchestration
  layer separate from library implementation
- **New test structure**: `tests/unit/test_template_module.cpp`,
  `tests/integration/test_pipeline.cpp` — unit and integration test
  separation
- **New `GETTING_STARTED.md`** — comprehensive onboarding guide with
  prerequisites, first build, IDE setup, dev container, CI understanding,
  customization, and troubleshooting
- **New `docs/NAMING_CONVENTIONS.md`** — detailed naming rules for
  directories, files, C++ symbols, CMake, tests, and Git
- **New `docs/release_checklist.md`** — release validation checklist

### Changed in v2.1.0

- **CMakeLists.txt** — major restructure: version bump to 2.1.0; project
  homepage updated to ObsidianHonorCoders org; library target now builds
  from `src/common/`, `src/architecture/`, and `src/compatibility_api.cpp`
  (no longer single `template_module.cpp`); executable moved to
  `src/app/main.cpp`; added `OHC_ENABLE_WERROR` option (default ON) for
  configurable warning-as-error; sanitizer flags simplified; compiler warning
  flags now respect `OHC_ENABLE_WERROR`; Doxygen integration updated to use
  `docs/DoxyPage/Doxyfile`; install/export/config package generation
  reformatted for readability; CPack inclusion retained
- **CI workflow** — completely rewritten from simple build-and-run to
  professional multi-job pipeline with 6 jobs: pre-commit, build-test
  (20-config matrix), static-analysis, format-check, security, docs, and
  release; uses actions/checkout@v7; explicit permissions; artifact upload;
  clang-tidy + cppcheck static analysis; Trivy vulnerability scanning;
  release automation with changelog generation
- **Project structure** — reorganized from flat to layered: headers now
  under `include/architecture/`, `include/common/`; sources under
  `src/architecture/`, `src/common/`, `src/app/`,
  `src/compatibility_api.cpp`; tests split into `unit/` and `integration/`;
  docs consolidated under `docs/` (CHANGELOG, CODE_OF_CONDUCT,
  CONTRIBUTING, LICENSE, SECURITY moved from root); build scripts
  (`build_and_run_project.cmake`, `cmakehelpers/`) removed in favor of
  presets and CI
- **Library target** — renamed internal structure: single `template_module`
  static library now aggregates all domain modules, utilities, and
  compatibility API; public headers remain under `include/` for install
- **README.md** — rewritten as minimal template overview pointing to
  `docs/README.md` and `GETTING_STARTED.md`; removed verbose build
  instructions
- **HOMEPAGE_URL** — changed from `Calileus/ohc-template-repo` to
  `ObsidianHonorCoders/ohc-template-repo`
- **GoogleTest** — upgraded to v1.14.0; FetchContent options reformatted

### Fixed in v2.1.0

- **Template drift** — eliminated duplicate/outdated guidance across root
  and docs folders by consolidating all documentation under `docs/`
- **Warning policy** — made warning-as-error configurable via
  `OHC_ENABLE_WERROR` (default ON) instead of hardcoded
- **Build scripts** — removed legacy `build_and_run_project.cmake` and
  `cmakehelpers/detect_generator.cmake`; replaced with standard CMake
  presets and CI workflow
- **Doxygen config** — fixed output directory and input paths; moved
  Doxyfile to `docs/DoxyPage/`; added custom CSS and logo
- **Install/export** — cleaned up CMake install commands with consistent
  formatting; fixed config package generation
- **Test discovery** — updated `tests/CMakeLists.txt` to match new source
  layout and module structure

## [2.0.0] - 2026-08-29

### Added in v2.0.0

- Reworked template documentation for fast onboarding: README and
  GETTING_STARTED guide
- Modernized CMake project structure with library target, install/export
  support, and config package generation
- Professional CI pipeline covering Linux, Windows, and macOS with multiple
  compilers
- Static analysis, security scanning, and release automation
- Naming conventions and template-rename automation for easier adaptation

### Changed in v2.0.0

- Simplified the repository layout and documentation to keep the template
  complete but lightweight
- Standardized release messaging and versioning around a clean v2.0 template
  baseline
- Improved build/test presets and developer workflow usability

### Fixed in v2.0.0

- Removed template drift and repeated guidance across docs
- Aligned version metadata and documentation to the v2.0 release state

## [1.3.0] - 2026-08-03

### Added in v1.3.0

- Initial template structure
- CMake presets for dev and CI builds
- GoogleTest integration via FetchContent
- Governance files (CODE_OF_CONDUCT, CONTRIBUTING, SECURITY, LICENSE)
- GitHub issue templates and PR template
- Doxygen configuration
- clang-format and editorconfig

### Changed in v1.3.0

- N/A (initial release)

## [1.2.0] - 2026-07-15

### Added in v1.2.0

- Basic project structure with include/, src/, tests/

## [1.1.0] - 2026-07-01

### Added in v1.1.0

- Initial CMakeLists.txt with modern CMake practices
- Template module example

## [1.0.0] - 2026-06-15

### Added in v1.0.0

- Repository initialization
- Basic C++ project structure
