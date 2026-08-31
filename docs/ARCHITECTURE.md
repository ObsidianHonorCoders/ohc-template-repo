# Architecture

This repository is a single-project C++ template intended to be used as one application per repository. The architecture is deliberately simple: one project, one executable, one library boundary, and a small set of clearly separated responsibilities. This keeps the code easy to understand, easy to rename for a new project, and easy to maintain without adding unnecessary organizational overhead.

## Goals

The architecture aims to keep the project:

- easy to navigate
- easy to rename for a new project
- easy to test
- easy to extend without coupling layers together
- consistent with the naming conventions in this repo
- scoped to a single product or application, not a monorepo

## Overall structure

```text
.
├── CMakeLists.txt
├── include/
│   ├── architecture/
│   ├── common/
│   ├── compatibility_api.hpp
├── src/
│   ├── app/
│   ├── architecture/
│   ├── common/
│   ├── compatibility_api.cpp
├── tests/
│   ├── integration/
│   ├── unit/
├── docs/
├── scripts/
├── cmake/
└── README.md
```

## Layering model

The project follows a simple layered pattern:

1. Public interface layer
2. Domain layer
3. Shared utility layer
4. Application entry point
5. Test layer

This keeps low-level implementation details away from the rest of the system while still allowing a small, cohesive project to remain readable.

### 1. Public interface layer

The public API is intentionally small and stable. It is exposed through headers such as:

- include/compatibility_api.hpp
- include/architecture/acquisition.hpp
- include/architecture/processing.hpp
- include/architecture/output.hpp

These headers define the contract that the rest of the project and downstream consumers use. Their role is to describe behavior, not to contain implementation logic.

Rules for this layer:

- keep it small and focused
- declare the public types and functions used by consumers
- avoid hiding business logic here
- include only what is needed for the interface to compile
- prefer clear names over clever abstractions

### 2. Domain/architecture layer

The domain layer groups features by responsibility instead of dumping everything into a monolithic implementation. In a single-project template, this is the main place where the application’s real behavior lives. The current structure is:

- acquisition: obtaining/normalizing raw input
- processing: transforming the acquired value into a usable state
- output: formatting the final result for the user or a target destination

Each module owns one concern and exposes a clear interface. This keeps the flow readable:

```text
raw input -> acquire -> process -> output
```

For a new project, keep the same pattern:

- create a module for each major responsibility area
- keep each module focused on one step in the workflow
- use narrow structs for intermediate data
- avoid cross-module logic leaks
- avoid creating multiple parallel product domains inside the same repo unless there is a real need

### 3. Shared utility layer

Shared helpers live in the common area:

- include/common/string_utils.hpp
- src/common/string_utils.cpp

This is where reusable, low-level helpers belong. Utilities should be small and generic, not project-specific business logic. A good rule is: if it is useful in multiple modules, it belongs here.

Maintainability guidance:

- keep utility functions generic
- avoid overloading a utility file with unrelated responsibilities
- prefer small, single-purpose functions

### 4. Application entry point

The executable entry point lives in:

- src/app/main.cpp

The application layer should coordinate the build flow but avoid owning most of the business logic. It should assemble the dependent pieces, call the system interfaces, and handle runtime concerns such as CLI arguments or environment setup.

For a new project, keep this file intentionally thin:

- parse inputs if necessary
- delegate logic to domain modules
- keep startup and orchestration logic simple

### 5. Test layer

The project separates tests by scope:

- tests/unit/ for isolated behavior verification
- tests/integration/ for end-to-end flow validation

This is useful because it supports two different questions:

- does a single module behave correctly?
- does the whole pipeline work together correctly?

The current test layout uses GoogleTest and follows a simple naming pattern:

- unit files: test_<module>.cpp
- integration files: test_<module>.cpp

Keep test names descriptive and aligned with the responsibility they validate.

## Naming conventions to preserve

This repository already documents its naming expectations in docs/NAMING_CONVENTIONS.md. The architecture should follow those conventions consistently.

Recommended conventions:

- directories: lowercase, compact, descriptive
- filenames: snake_case
- classes/structs: PascalCase
- functions: snake_case
- namespaces: snake_case
- tests: test_<module>.cpp
- CMake targets and variables: UPPER_SNAKE_CASE or project-appropriate names

The important point is consistency. A clean architecture is not only about folder layout; it also depends on naming that makes the structure predictable.

## Build and dependency pattern

The CMake configuration in the root project follows a simple build structure:

- a static library target is created for the reusable implementation
- the executable links against that library
- tests link against the same library and GoogleTest

This is a strong default pattern for any new project because it keeps the build honest:

- production logic is compiled once as a library
- tests validate behavior against the same code used by the app
- the app stays as the orchestration layer, not the implementation layer

Recommended default rule:

- keep production code in a library target when it is reused or testable
- keep the executable small and focused on startup
- avoid writing business logic directly in the main program

## Maintainability principles

A project remains clean when it consistently follows a few simple rules.

### Keep responsibilities separate

Each module should answer one question:

- acquisition: what input did we receive?
- processing: how should it be transformed?
- output: how should it be expressed?
- common: what utility code is shared?

If a file starts doing unrelated work, it likely belongs in a different module.

### Minimize hidden dependencies

Public headers should declare the includes they directly need. This keeps code easier to compile, understand, and refactor.

### Prefer explicit flow over implicit magic

The architecture should make it obvious what happens from input to output. Avoid hiding important transformations behind unclear utility behavior or deeply nested code.

### Keep the public API stable

The public interface should be a small, intentional contract. Hidden implementation changes should not force consumers to know the internal architecture.

### Keep tests close to the system behavior

Tests should validate actual behavior rather than implementation details. That means they should focus on observable outcomes and meaningful workflow transitions.

## Applying this architecture to a new project

For a new C++ project derived from this template, use this workflow:

1. Rename the project identity in the root CMake configuration.
2. Keep the single-project structure: include/, src/, tests/, docs/, scripts/, cmake/.
3. Add domain modules only for real responsibilities in the same application.
4. Keep shared logic in common/ only when it is truly reusable.
5. Maintain a thin application entry point.
6. Add unit tests for module behavior and integration tests for end-to-end flows.
7. Preserve naming consistency across files, symbols, and folders.
8. Refactor when module boundaries become fuzzy or files grow too large.

## Recommended project pattern

For a single-project repo template, the default pattern should stay lean:

```text
include/
  project_name/
    feature_a/
    feature_b/
  common/

src/
  app/
  project_name/
    feature_a/
    feature_b/
  common/

tests/
  unit/
  integration/
```

This keeps the project scalable enough for a single application without implying a multi-project or monorepo layout.

## Summary

The current architecture is intentionally simple, but it is already organized in a maintainable way for a single-project repository:

- clear module boundaries
- mirrored include/src structure
- public API for stable consumers
- thin executable layer
- test separation by responsibility
- naming standards that are easy to apply

The key to keeping it clean is to stay disciplined: one repo, one product, one main executable, and only the module boundaries required by the application’s responsibilities. This is the maintainable default for this template.
