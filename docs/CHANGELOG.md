# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- Cross-platform build script (cmakehelpers/quick_build.cmake)
- Governance files (CODE_OF_CONDUCT, CONTRIBUTING, SECURITY, LICENSE)
- GitHub issue templates and PR template
- Doxygen configuration
- clang-format and editorconfig

### Changed in v1.3.0

- N/A (initial release)

## [1.2.0] - 2026-07-15

### Added in v1.2.0

- cmakehelpers/detect_generator.cmake for platform detection
- Basic project structure with include/, src/, tests/

## [1.1.0] - 2026-07-01

### Added in v1.1.0

- Initial CMakeLists.txt with modern CMake practices
- Template module example

## [1.0.0] - 2026-06-15

### Added in v1.0.0

- Repository initialization
- Basic C++ project structure
