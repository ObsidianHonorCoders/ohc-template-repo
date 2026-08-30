# Naming Conventions

This document defines the naming conventions for files, directories, and
symbols in this repository.

## File and Directory Naming

- Directories: `kebab-case`
  - Example: `cmake-helpers/`, `ci-config/`
- CMake files: `snake_case.cmake`
  - Example: `detect_generator.cmake`
- C++ headers: `snake_case.hpp`
  - Example: `template_module.hpp`
- C++ sources: `snake_case.cpp`
  - Example: `template_module.cpp`
- Test files: `test_<module>.cpp`
  - Example: `test_template_module.cpp`
- Documentation: `kebab-case.md`
  - Example: `release-checklist.md`
- Config files: `kebab-case.ext`
  - Example: `.clang-format`, `.editorconfig`
- Scripts: `kebab-case.sh` or `kebab-case.ps1`
  - Example: `rename-template.sh`
- GitHub workflows: `kebab-case.yml`
  - Example: `ci.yml`
- License: `LICENSE`
- Changelog: `CHANGELOG.md`
- Readme: `README.md`

## C++ Symbol Naming

- Namespaces: `snake_case`
  - Example: `template_repo`
- Classes and structs: `PascalCase`
  - Example: `TemplateModule`
- Functions and methods: `snake_case`
  - Example: `build_greeting()`
- Variables: `snake_case`
  - Example: `user_name`
- Constants: `UPPER_SNAKE_CASE`
  - Example: `MAX_BUFFER_SIZE`
- Macros: `UPPER_SNAKE_CASE`
  - Example: `OHC_ASSERT`
- Template parameters: `PascalCase`
  - Example: `ValueType`
- Enum values: `UPPER_SNAKE_CASE`
  - Example: `Status::SUCCESS`
- Type aliases: `PascalCase`
  - Example: `using StringView = std::string_view;`

## CMake Naming

- Variables: `UPPER_SNAKE_CASE`
- Targets: `PascalCase`
- Options: `UPPER_SNAKE_CASE`
- Functions and macros: `snake_case`
- Cache variables: `UPPER_SNAKE_CASE`

## Git Conventions

- Branch names: `type/short-description`
  - Example: `feat/add-logging`
- Commit messages: imperative, present tense
  - Example: `add feature`
- PR titles: `<type>(scope): summary`
  - Example: `feat(core): add config parser`
- Tags: `v<major>.<minor>.<patch>`
  - Example: `v1.3.0`

## Renaming Checklist for Template Consumers

When creating a new repository from this template:

1. Rename the project in `CMakeLists.txt`.

   ```cmake
   project(your_project_name VERSION 1.0.0 LANGUAGES CXX)
   ```

2. Update the executable name.

   ```cmake
   set(EXE_NAME "your_app_name")
   ```

3. Update the namespace in C++ files.

   ```cpp
   namespace your_project { ... }
   ```

4. Update the `Doxyfile` project name.

   ```text
   PROJECT_NAME = "Your Project Name"
   ```

5. Update `README.md` with project-specific information.
6. Update `.github/CODEOWNERS` with actual maintainers.
7. Update `SECURITY.md` with project-specific contacts.
8. Update `CONTRIBUTING.md` if the workflow differs.
9. Review `./.github/ISSUE_TEMPLATE` for relevance.
10. Run the rename script from `scripts/rename-template.ps1` or `.sh`.

## Automated Enforcement

- `.clang-format` enforces C++ formatting.
- `cmake-format` enforces CMake formatting.
- Pre-commit hooks check naming conventions.
- CI validates formatting on every PR.
