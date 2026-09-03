/// @file      main.cpp
/// @namespace template_repo
/// @brief     Entry point for the enterprise-style sample application.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This is the main entry point demonstrating the complete architecture pipeline.
///            It uses the compatibility facade to build a greeting with the full pipeline:
///            input acquisition -> processing -> output generation.

#include "compatibility_api.hpp"

#include <iostream>

/// @brief Main entry point for the OHC template repository sample application.
/// @return Exit code (0 for success).
/// @details Demonstrates the enterprise-style architecture by:
///          1. Calling the compatibility facade BuildGreeting() with a test name
///          2. The facade chains: input::AcquireInput -> processing::ProcessInput -> output::BuildOutput
///          3. Printing the resulting greeting to stdout
int main()
{
  // Demonstrate the full architecture pipeline with a test name containing whitespace
  std::cout << template_repo::BuildGreeting("  OHC  ") << "\n";
  return 0;
}
