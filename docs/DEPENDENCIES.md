# Dependencies and Requirements

This guide covers all required and optional tools for developing with
the OHC C++ template.

## Required Tools (All Platforms)

| Tool | Minimum | Install |
|------|---------|---------|
| CMake | 3.25+ | `apt install cmake` |
| Ninja | 1.10+ | `apt install ninja-build` |
| C++ Compiler | C++17 support | Platform-specific |
| Git | 2.30+ | Standard install |

## Platform-Specific Compilers

### Windows

**Recommended**: Visual Studio 2022 Community Edition
- Download: https://visualstudio.microsoft.com/
- Required workload: "Desktop development with C++"
- Includes MSVC, CMake, and Ninja

**Alternative**: MinGW-w64
```powershell
choco install mingw  # via Chocolatey
```

### Linux

**GCC 11+ (Recommended)**:
```bash
sudo apt-get install build-essential cmake ninja-build
```

**Clang 14+ (Alternative)**:
```bash
sudo apt-get install clang cmake ninja-build
```

### macOS

**Xcode Command Line Tools (Recommended)**:
```bash
xcode-select --install
```

**Homebrew (Alternative)**:
```bash
brew install gcc cmake ninja
```

## Optional but Recommended

| Tool | Purpose | Install |
|------|---------|---------|
| clang-format | Code formatting | Bundled with LLVM |
| clang-tidy | Static analysis | Bundled with LLVM |
| Doxygen | API documentation | `apt install doxygen` |
| cppcheck | Static analysis | `apt install cppcheck` |
| pre-commit | Git hooks | `pip install pre-commit` |

### Install Optional Tools

**Linux**:
```bash
sudo apt-get install clang-format clang-tidy doxygen cppcheck
python3 -m pip install pre-commit
```

**macOS**:
```bash
brew install clang-format doxygen cppcheck
pip install pre-commit
```

**Windows (via Chocolatey)**:
```powershell
choco install llvm doxygen.install cppcheck
python -m pip install pre-commit
```

## Fastest Setup: Dev Container

**No local installation needed!** Use Docker + VS Code:

1. Install [Docker Desktop](https://www.docker.com/products/
   docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/) +
   [Dev Containers extension](https://marketplace.visualstudio.com/
   items?itemName=ms-vscode-remote.remote-containers)
3. Open folder in VS Code → **Reopen in Container**

The container includes:
- CMake 3.28, Ninja
- GCC 13, Clang 18
- Doxygen, cppcheck, valgrind, lcov
- pre-commit, VS Code C++ extensions

## Verify Installation

Test your setup with:

```bash
cmake --version        # Should be 3.25+
ninja --version        # Should be 1.10+
cc --version           # Should show your compiler
```

## Next Steps

- See [GETTING_STARTED.md](../GETTING_STARTED.md) to begin
- See [CMAKE_CONFIGURATION.md](CMAKE_CONFIGURATION.md) for
  preset options
