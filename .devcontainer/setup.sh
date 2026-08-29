#!/usr/bin/env bash
# Dev container post-create setup script
# Runs automatically after container creation

set -euo pipefail

echo "🔧 Setting up development environment..."

# Update package list
sudo apt-get update

# Install additional tools
sudo apt-get install -y \
  clang-format-18 \
  clang-tidy-18 \
  cppcheck \
  doxygen \
  graphviz \
  lcov \
  gcovr \
  valgrind \
  bear \
  python3-pip \
  python3-venv

# Create symlinks for clang tools
sudo ln -sf /usr/bin/clang-format-18 /usr/local/bin/clang-format
sudo ln -sf /usr/bin/clang-tidy-18 /usr/local/bin/clang-tidy

# Install Python tools
pip3 install --user \
  pre-commit \
  cmake-format \
  codespell \
  pyyaml

# Install pre-commit hooks
cd /workspaces/ohc-template-repo
pre-commit install
pre-commit install --hook-type commit-msg

# Configure Git
git config --global core.autocrlf input
git config --global pull.rebase false
git config --global init.defaultBranch main

# Setup CMake presets
if [ ! -f CMakeUserPresets.json ]; then
  cat > CMakeUserPresets.json << 'EOF'
{
  "version": 6,
  "configurePresets": [
    {
      "name": "dev-container",
      "inherits": "dev",
      "displayName": "Dev Container Debug",
      "binaryDir": "${sourceDir}/build/dev-container",
      "cacheVariables": {
        "CMAKE_CXX_COMPILER": "/usr/bin/clang++",
        "CMAKE_C_COMPILER": "/usr/bin/clang",
        "CMAKE_EXPORT_COMPILE_COMMANDS": "ON"
      }
    }
  ]
}
EOF
  echo "✅ Created CMakeUserPresets.json"
fi

# Generate compile_commands.json for clangd
cmake --preset dev-container 2>/dev/null || true

echo "✅ Development environment ready!"
echo ""
echo "Available commands:"
echo "  cmake --preset dev-container    # Configure (Debug)"
echo "  cmake --build --preset dev-container-build  # Build"
echo "  ctest --preset dev-container-test           # Test"
echo "  pre-commit run --all-files      # Run all checks"
echo ""
echo "Happy coding! 🚀"
