# Packaging and Distribution

This guide covers building, installing, and packaging the OHC
template project for distribution to downstream consumers.

## Installation Targets

The project defines install rules for libraries, headers, and
executables. These allow consumers to install and use your project
as a system package.

### What Gets Installed

```text
/usr/local/
├── lib/
│   └── libtemplate_module.a         # Static library
├── include/
│   └── template_repo/
│       ├── compatibility_api.hpp     # Public headers
│       └── architecture/
│           ├── acquisition.hpp
│           ├── processing.hpp
│           └── output.hpp
├── bin/
│   └── ohc_template_app             # Executable
└── cmake/
    ├── template_repo-config.cmake   # CMake config
    └── template_repo-targets.cmake  # CMake targets
```

### Default Installation Path

Installs to system standard locations (Linux/macOS):

- Libraries: `/usr/local/lib/`
- Headers: `/usr/local/include/`
- Executables: `/usr/local/bin/`
- CMake config: `/usr/local/cmake/`

## Building for Installation

### 1. Configure and Build

```bash
# Release build (optimized for distribution)
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel 4

# Or use preset
cmake --preset ci
cmake --build --preset ci-build
```

### 2. Run Tests (Before Installing)

```bash
ctest --preset ci-test --output-on-failure
```

## Installing

### System-Wide Installation

#### Requires admin/sudo access

```bash
# Install to default locations
sudo cmake --install build

# Verify installation
ls /usr/local/include/template_repo/
ls /usr/local/lib/libtemplate_module.a
```

### User-Local Installation

#### No admin required, installs to home directory

```bash
# Install to ~/.local/
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=~/.local

cmake --install build

# Add to PATH for executables
export PATH=~/.local/bin:$PATH

# Add to pkg-config for libraries
export PKG_CONFIG_PATH=~/.local/lib/pkgconfig:$PKG_CONFIG_PATH
```

### Custom Installation Directory

```bash
# Install to specific location
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=/opt/myapp

cmake --install build

# Use in another project
-DCMAKE_PREFIX_PATH=/opt/myapp
```

### Windows Installation

```powershell
# Install to Program Files
cmake -S . -B build `
  -DCMAKE_INSTALL_PREFIX="C:\Program Files\template_repo"

cmake --install build
```

## Consuming the Installed Library

Once installed, downstream projects can use your library with CMake:

### Method 1: find_package (Recommended)

Requires your project provides CMake config files
(generated from `cmake/template_repo-config.cmake.in`).

**In downstream CMakeLists.txt**:

```cmake
cmake_minimum_required(VERSION 3.25)
project(my_app)

# Find installed package
find_package(template_repo REQUIRED)

# Create executable
add_executable(my_app main.cpp)

# Link against installed library
target_link_libraries(my_app PRIVATE template_repo::template_module)
```

**Configure downstream project**:

```bash
cmake -S . -B build -DCMAKE_PREFIX_PATH=/usr/local
cmake --build build
```

### Method 2: Manual CMake Configuration

If config files aren't available:

```cmake
find_library(TEMPLATE_REPO_LIB NAMES template_module)
find_path(TEMPLATE_REPO_INCLUDE compatibility_api.hpp
  PATH_SUFFIXES template_repo)

add_executable(my_app main.cpp)
target_include_directories(my_app PRIVATE ${TEMPLATE_REPO_INCLUDE})
target_link_libraries(my_app PRIVATE ${TEMPLATE_REPO_LIB})
```

### Method 3: pkg-config

If pkg-config files are installed:

```bash
# Query installed package
pkg-config --cflags --libs template_repo

# Use in build
g++ -o my_app main.cpp $(pkg-config --cflags --libs template_repo)
```

## Creating Distribution Packages

### Linux: Debian Package

Create `.deb` package for distribution on Debian/Ubuntu systems.

**Simple approach** (requires `debhelper`):

```bash
apt-get install debhelper
cd /path/to/repo
debuild -us -uc
```

Generates `../template_repo_*.deb` for installation on other
machines.

### Linux: RPM Package

Create `.rpm` package for Red Hat/Fedora systems.

**Using CMake and CPack**:

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cpack --config CPackConfig.cmake -G RPM
```

Generates `.rpm` file in `build/`.

### CMake CPack (All Platforms)

Use CMake's CPack to generate installers automatically.

**Configure CPack in CMakeLists.txt**:

```cmake
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
```

**Then generate**:

```bash
cmake -S . -B build -DBUILD_TESTING=OFF
cd build && cpack -G ZIP  # Windows ZIP
cpack -G TGZ              # Linux TAR.GZ
cpack -G DragNDrop        # macOS DMG
```

### Creating Source Distribution

Package source code for redistribution:

```bash
# Create tarball of source
cd ..
tar --exclude-vcs --exclude build --exclude .github \
  -czf template_repo-2.2.0.tar.gz template_repo/

# Or use cmake
cmake --preset ci
cpack --config build/CPackSourceConfig.cmake -G TGZ
```

## Release Checklist

Before releasing a distribution package:

- [ ] Update version in CMakeLists.txt
- [ ] Update CHANGELOG.md
- [ ] Run full test suite: `ctest --preset ci-test`
- [ ] Build in Release mode: `cmake --preset ci`
- [ ] Run static analysis (CI does this automatically)
- [ ] Generate documentation: `cmake --build build --target docs`
- [ ] Verify installation: `cmake --install build --prefix /tmp/test-install`
- [ ] Test consumption in downstream project
- [ ] Tag release: `git tag v2.2.0 && git push --tags`

## Semantic Versioning

This project follows [Semantic Versioning](
https://semver.org/):

- **MAJOR** (2.0.0 → 3.0.0): Breaking API changes
- **MINOR** (2.1.0 → 2.2.0): New backward-compatible features
- **PATCH** (2.1.2 → 2.1.3): Bug fixes only

Update version in:

1. `CMakeLists.txt` line with `VERSION`
2. Git tag as `vMAJOR.MINOR.PATCH`
3. `docs/CHANGELOG.md`

## Backwards Compatibility

When updating public headers:

- **Adding optional parameters**: OK (use default values)
- **Renaming symbols**: Breaking (MAJOR version bump)
- **Changing function signature**: Breaking (MAJOR version bump)
- **Removing public API**: Breaking (MAJOR version bump)
- **Adding new symbols**: Not breaking (MINOR version bump)

## Next Steps

- See [CMAKE_OPTIONS.md](CMAKE_OPTIONS.md) for build options
- See [CMAKE_CONFIGURATION.md](CMAKE_CONFIGURATION.md) for
  installation configuration
- See [GETTING_STARTED.md](../GETTING_STARTED.md) for basic setup
