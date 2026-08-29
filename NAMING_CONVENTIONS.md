# Naming Conventions

This document defines the mandatory naming conventions for all files, directories, and symbols in this repository.

## File & Directory Naming

| Type | Convention | Examples |
|------|------------|----------|
| **Directories** | `kebab-case` (lowercase, hyphen-separated) | `cmake-helpers/`, `ci-config/`, `third-party/` |
| **CMake files** | `snake_case.cmake` | `detect-generator.cmake`, `build-and-run.cmake` |
| **C++ Headers** | `snake_case.hpp` | `template-module.hpp`, `utils.hpp` |
| **C++ Sources** | `snake_case.cpp` | `template-module.cpp`, `main.cpp` |
| **Test files** | `test_<module>.cpp` | `test-template-module.cpp` |
| **Documentation** | `kebab-case.md` | `release-checklist.md`, `architecture.md` |
| **Config files** | `kebab-case.ext` | `.clang-format`, `.editorconfig`, `Doxyfile` |
| **Scripts** | `kebab-case.sh` / `kebab-case.ps1` | `setup-dev-env.sh`, `release.ps1` |
| **GitHub workflows** | `kebab-case.yml` | `ci.yml`, `release.yml`, `dependabot.yml` |
| **License** | `LICENSE` (uppercase, no extension) | `LICENSE` |
| **Changelog** | `CHANGELOG.md` (uppercase) | `CHANGELOG.md` |
| **Readme** | `README.md` (uppercase) | `README.md` |

## C++ Symbol Naming

| Symbol Type | Convention | Example |
|-------------|------------|---------|
| **Namespaces** | `snake_case` | `template_repo`, `ohc::utils` |
| **Classes/Structs** | `PascalCase` | `TemplateModule`, `ConfigManager` |
| **Functions/Methods** | `snake_case` | `build_greeting()`, `parse_config()` |
| **Variables** | `snake_case` | `user_name`, `max_retries` |
| **Constants** | `UPPER_SNAKE_CASE` | `MAX_BUFFER_SIZE`, `DEFAULT_PORT` |
| **Macros** | `UPPER_SNAKE_CASE` | `OHC_ASSERT`, `DEBUG_LOG` |
| **Template Parameters** | `PascalCase` | `typename ValueType` |
| **Enum Values** | `UPPER_SNAKE_CASE` | `Status::SUCCESS`, `Color::RED` |
| **Type Aliases** | `PascalCase` | `using StringView = std::string_view;` |

## CMake Naming

| Symbol Type | Convention | Example |
|-------------|------------|---------|
| **Variables** | `UPPER_SNAKE_CASE` | `CMAKE_CXX_STANDARD`, `EXE_NAME` |
| **Targets** | `PascalCase` | `TemplateModule`, `OhcTemplateApp` |
| **Options** | `UPPER_SNAKE_CASE` | `BUILD_TESTING`, `ENABLE_SANITIZERS` |
| **Functions/Macros** | `snake_case` | `add_executable_with_tests()` |
| **Cache Variables** | `UPPER_SNAKE_CASE` | `CMAKE_BUILD_TYPE` |

## Git Conventions

| Element | Convention |
|---------|------------|
| **Branch names** | `type/short-description` (e.g., `feat/add-logging`, `fix/null-pointer`) |
| **Commit messages** | Imperative, present tense: `add feature`, `fix bug`, `update docs` |
| **PR titles** | `<type>(scope): summary` (e.g., `feat(core): add config parser`) |
| **Tags** | `v<major>.<minor>.<patch>` (e.g., `v1.3.0`, `v2.0.0-rc1`) |

## Renaming Checklist for Template Consumers

When creating a new repository from this template:

1. **Rename project in CMakeLists.txt:**
   ```cmake
   project(your_project_name VERSION 1.0.0 LANGUAGES CXX)
   ```

2. **Update executable name:**
   ```cmake
   set(EXE_NAME "your_app_name")
   ```

3. **Update namespace in C++ files:**
   ```cpp
   namespace your_project { ... }
   ```

4. **Update Doxyfile:**
   ```
   PROJECT_NAME = "Your Project Name"
   ```

5. **Update README.md** with project-specific description

6. **Update .github/CODEOWNERS** with actual maintainers

7. **Update SECURITY.md** with project-specific contacts

8. **Update CONTRIBUTING.md** if workflow differs

9. **Review .github/ISSUE_TEMPLATE/** for relevance

10. **Run rename script** (see `scripts/rename-template.ps1` or `.sh`)

## Automated Enforcement

- `.clang-format` enforces C++ formatting
- `cmake-format` enforces CMake formatting (via pre-commit)
- Pre-commit hooks check naming conventions
- CI pipeline validates formatting on every PR