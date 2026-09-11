# Troubleshooting Guide

Common issues and solutions when developing with the OHC
template.

## CMake Issues

### "CMake version 3.25 or higher is required"

**Cause**: Your CMake is too old
**Solution**: Update CMake

```bash
# Linux
sudo apt-get install --only-upgrade cmake

# macOS
brew upgrade cmake

# Windows
choco upgrade cmake

# Or download from https://cmake.org/download/
```

Verify: `cmake --version` should show 3.25+

### "Ninja not found"

**Cause**: Ninja is not installed or not in PATH
**Solution A**: Install Ninja

```bash
# Linux
sudo apt-get install ninja-build

# macOS
brew install ninja

# Windows
choco install ninja
```

**Solution B**: Use different generator

```bash
cmake -S . -B build -G "Unix Makefiles"
```

### "Could not find C++ compiler"

**Cause**: No C++17-capable compiler installed
**Solution**: Install compiler for your platform

See [DEPENDENCIES.md](DEPENDENCIES.md) for platform-specific
instructions.

**Or specify compiler explicitly**:

```bash
cmake -S . -B build \
  -DCMAKE_CXX_COMPILER=/path/to/compiler
```

Find available compilers:

```bash
# Linux/macOS
which gcc g++ clang clang++

# Windows (MSVC)
where cl.exe
```

### "build folder has suspicious content"

**Cause**: Stale CMake cache from previous configuration
**Solution**: Clean and reconfigure

```bash
rm -rf build/
cmake --preset dev
```

### "Configuration fails with unrelated error"

**Cause**: CMakeCache.txt has stale values
**Solution**: Delete cache file

```bash
rm build/CMakeCache.txt
cmake --preset dev
```

## Build Failures

### "fatal error: cannot find -lm" or similar linking error

**Cause**: Missing system library or linker path
**Solution**: Install development libraries

```bash
# Linux
sudo apt-get install build-essential

# macOS
xcode-select --install
```

### "multiple definition of symbol"

**Cause**: Duplicate definition in header or object files
**Solution**: Check for missing `#pragma once` or header guards

```cpp
// In your headers
#pragma once
// or
#ifndef MY_HEADER_HPP
#define MY_HEADER_HPP
// ... content ...
#endif
```

### "undefined reference to `main`"

**Cause**: Executable target missing `main()` function
**Solution**: Ensure `src/app/main.cpp` exists and has
`int main()` function

### "warnings treated as errors"

**Cause**: `OHC_ENABLE_WERROR=ON` (default)
**Solution A**: Fix the warning

- Add missing includes
- Remove unused variables
- Fix deprecated function calls

**Solution B**: Temporarily disable for testing

```bash
cmake -S . -B build -DOHC_ENABLE_WERROR=OFF
```

## Test Failures

### "No tests were found"

**Cause**: Test files not in correct location or not named
correctly
**Solution**: Ensure test file is in `tests/unit/` or
`tests/integration/` and ends with `.cpp`

**Or**: Manually list test files in `tests/CMakeLists.txt`

### "GoogleTest download failed"

**Cause**: Network issue or GitHub is down
**Solution A**: Check internet connection

**Solution B**: Verbose output to see error

```bash
cmake -S . -B build -DFETCHCONTENT_QUIET=OFF
```

**Solution C**: Offline build - pre-download GoogleTest
separately and modify CMakeLists.txt

### "Test runs but assertion fails"

**Cause**: Test logic error or environment issue
**Solution**: Add debug output

```cpp
TEST(MyTest, DebugExample)
{
  auto result = function_under_test();
  std::cout << "Result: " << result << std::endl;
  EXPECT_EQ(expected, result);
}
```

Run with output:

```bash
ctest --preset dev-test --output-on-failure
```

### "Flaky test - passes sometimes, fails sometimes"

**Cause**: Race condition, uninitialized state, or external
dependency
**Solution**:

1. Check for shared state between tests
2. Initialize all variables
3. Check for timing-dependent code
4. Mock external dependencies (files, network)

## Pre-commit Hooks

### "pre-commit failed" in git commit

**Cause**: Code formatting or style issue detected
**Solution A**: Let pre-commit auto-fix it

```bash
# Install pre-commit first
pip install pre-commit
pre-commit install --install-hooks

# Auto-fix and commit again
git add .
git commit -m "message"
```

**Solution B**: Fix manually

```bash
# See what failed
pre-commit run --all-files

# Fix manually then:
git add changes
git commit
```

### "clang-format modified files"

**Cause**: Code doesn't match formatting style
**Solution**: Re-format

```bash
# Auto-format all C++ files
find src include tests -name "*.cpp" -o -name "*.hpp" | \
  xargs clang-format -i
```

Or let pre-commit do it:

```bash
pre-commit run --all-files  # Auto-fixes formatting
git add .
git commit
```

### "markdownlint error"

**Cause**: Markdown formatting issue (trailing spaces, line
breaks)
**Solution**: Pre-commit auto-fixes most issues

```bash
pre-commit run markdownlint --all-files
git add .
git commit
```

### "shellcheck: syntax error"

**Cause**: Shell script has syntax or style issue
**Solution**: Fix script syntax

```bash
# Find issues
shellcheck scripts/*.sh

# Fix and test
bash -n scripts/rename-template.sh  # Syntax check only
bash scripts/rename-template.sh --help
```

## Installation Issues

### "Permission denied" when installing

**Cause**: Installing to system directory without permissions
**Solution A**: Use `sudo`

```bash
sudo cmake --install build
```

**Solution B**: Install to home directory

```bash
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=~/.local
cmake --install build
export PATH=~/.local/bin:$PATH
```

### "Could not find config file" after install

**Cause**: Package not in CMake search path
**Solution**: Set CMAKE_PREFIX_PATH

```bash
cmake -DCMAKE_PREFIX_PATH=/opt/myapp \
  -DCMAKE_MODULE_PATH=/opt/myapp/cmake
```

## Development Container Issues

### "Could not connect to Docker daemon"

**Cause**: Docker Desktop not running
**Solution**: Start Docker Desktop

```bash
# Linux
sudo systemctl start docker

# macOS/Windows
# Open Docker Desktop app
```

### "Container build failed"

**Cause**: Dockerfile or setup script issue
**Solution**: Check logs and rebuild

```bash
# Rebuild container (no cache)
# In VS Code: Dev Containers: Rebuild Container
```

## Windows-Specific Issues

### "MSVC compiler not found"

**Cause**: Visual Studio or Build Tools not installed
**Solution**: Install Visual Studio 2022 Community

- Download: <https://visualstudio.microsoft.com/>
- Workload: "Desktop development with C++"
- Include: C++, CMake, Ninja

### "PowerShell execution policy"

**Cause**: Script won't run due to execution policy
**Solution**: Set policy for current session

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\scripts\rename-template.ps1 -ProjectName MyProject
```

### "Path too long" error

**Cause**: Windows has 260-character path limit
**Solution**: Enable long paths in Windows 10+

```powershell
# As Administrator
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\
  Control\FileSystem" -Name "LongPathsEnabled" `
  -Value 1 -PropertyType DWORD -Force
```

## Getting Help

1. Check this troubleshooting guide
2. See relevant doc:
   - [CMAKE_OPTIONS.md](CMAKE_OPTIONS.md) for CMake
   - [DEPENDENCIES.md](DEPENDENCIES.md) for install issues
   - [TESTING.md](TESTING.md) for test issues
   - [ARCHITECTURE.md](ARCHITECTURE.md) for design questions
3. Run with verbose output: `cmake -S . -B build --debug-output`
4. Check [GitHub Issues](
   https://github.com/ObsidianHonorCoders/ohc-template-repo/issues)
5. Post issue with:
   - Platform (Windows/Linux/macOS)
   - Error message (full output)
   - Command that failed
   - Output of `cmake --version` and compiler version
