# CMake Configuration Guide

This guide covers CMake project setup, presets, and workflow for
developing with the OHC template.

## Quick Reference

**Configure and build using presets** (recommended):

```bash
# Developer build (Debug)
cmake --preset dev
cmake --build --preset dev-build

# CI build (Release)
cmake --preset ci
cmake --build --preset ci-build

# Run tests
ctest --preset dev-test --output-on-failure
```

## CMake Presets

Presets in [CMakePresets.json](../CMakePresets.json) define
standard workflows. Two main presets:

### dev: Developer Debug Build

**Purpose**: Local development with full debug info
**Build type**: Debug (no optimization, debug symbols)
**Testing**: Enabled
**Output**: `build/dev/`
**Use when**: Writing and testing code locally

```bash
cmake --preset dev
cmake --build --preset dev-build --parallel 4
ctest --preset dev-test --output-on-failure
```

### ci: CI Release Build

**Purpose**: Release packaging and final testing
**Build type**: Release (optimized, no symbols)
**Testing**: Enabled
**Output**: `build/ci/`
**Use when**: Preparing releases or performance testing

```bash
cmake --preset ci
cmake --build --preset ci-build --parallel 4
ctest --preset ci-test --output-on-failure
```

## Manual Configuration (Without Presets)

For custom builds, use cmake directly:

```bash
# Basic debug build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug

# Release with all tests
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTING=ON

# With specific compiler
cmake -S . -B build -DCMAKE_CXX_COMPILER=clang++

# With ninja instead of make
cmake -S . -B build -G Ninja
```

For all available options, see
[CMAKE_OPTIONS.md](CMAKE_OPTIONS.md).

## Build Commands

### Standard Build

```bash
# Build everything
cmake --build build

# Build with 4 parallel jobs
cmake --build build --parallel 4

# Build specific target
cmake --build build --target template_module
```

### Verbose Output

Show actual compiler commands:

```bash
cmake --build build --verbose
```

### Clean Build

```bash
# Remove build directory completely
rm -rf build/

# Rebuild from scratch
cmake --preset dev
cmake --build --preset dev-build
```

## Running the Application

After building:

```bash
# Debug build
./build/dev/bin/ohc_template_app

# Release build
./build/ci/bin/ohc_template_app
```

## Running Tests

```bash
# All tests with output on failure
ctest --preset dev-test --output-on-failure

# Specific test by regex
ctest --preset dev-test -R "UnitTests" --output-on-failure

# Verbose output (shows each test)
ctest --preset dev-test --output-on-failure -VV

# Stop after first failure
ctest --preset dev-test -R "TestName" --stop-on-failure
```

See [TESTING.md](TESTING.md) for detailed testing guide.

## Build Targets

The project defines these CMake targets:

| Target | Type | Produces |
|--------|------|----------|
| `template_module` | Library | `.a` or `.lib` |
| `ohc_template_app` | Executable | Binary |
| `test_ohc_template_app` | Executable | Test runner |
| `test_ohc_template_app_integration` | Executable | Test runner |
| `docs` | Custom | Doxygen HTML |

Build specific target:

```bash
cmake --build build --target template_module
cmake --build build --target docs
```

## Installation

Install built artifacts to system:

```bash
cmake -S . -B build
cmake --build build
sudo cmake --install build
```

**Install location** (default):

- Libraries: `/usr/local/lib/`
- Headers: `/usr/local/include/`
- Executables: `/usr/local/bin/`

**Custom install prefix**:

```bash
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=/opt/myapp
cmake --install build
```

## Generators

CMake can generate build files for different tools:

### Ninja (Recommended)

Fastest, most common in modern projects:

```bash
cmake -S . -B build -G Ninja
cmake --build build
```

### Unix Makefiles

Standard on Linux/macOS:

```bash
cmake -S . -B build -G "Unix Makefiles"
make -C build -j4
```

### Visual Studio (Windows)

MSVC integrated environment:

```powershell
cmake -S . -B build -G "Visual Studio 17"
cmake --build build --config Release
```

### Xcode (macOS)

macOS IDE integration:

```bash
cmake -S . -B build -G Xcode
cmake --build build --config Debug
```

## Out-of-Source Builds

The template uses out-of-source builds: source code in `.` and
build artifacts in `build/`. This keeps repo clean.

**Advantage**: Remove all build artifacts with `rm -rf build/`

## Environment Variables

### CMAKE_BUILD_PARALLEL_LEVEL

Set default parallel build jobs:

```bash
export CMAKE_BUILD_PARALLEL_LEVEL=8
cmake --build build  # Uses 8 jobs
```

### CC and CXX

Set compiler:

```bash
export CC=gcc-11
export CXX=g++-11
cmake -S . -B build
```

## Troubleshooting CMake

**"CMake not found"**: Install from
[DEPENDENCIES.md](DEPENDENCIES.md)

**"Ninja not found"**: Install ninja or use
`-G "Unix Makefiles"`

**"C++ compiler not found"**: Specify with
`-DCMAKE_CXX_COMPILER=/path/to/compiler`

**"Build fails with warnings"**: If `OHC_ENABLE_WERROR=ON`,
disable with `-DOHC_ENABLE_WERROR=OFF`

**"Configuration cache conflict"**: Delete `build/` and
reconfigure:

```bash
rm -rf build/
cmake --preset dev
```

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more issues.

## Next Steps

- Run tests: `ctest --preset dev-test --output-on-failure`
- See [TESTING.md](TESTING.md) for writing tests
- See [CMAKE_OPTIONS.md](CMAKE_OPTIONS.md) for all options
- See [ARCHITECTURE.md](ARCHITECTURE.md) for project structure
