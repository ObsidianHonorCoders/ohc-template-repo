/// @file      main.cpp
/// @namespace template_repo
/// @brief     Entry point for the OHC template application.
/// @author    Calileus
/// @date      2026-08-30
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   Starts the sample application and prints a greeting defined by
///            the template module API.

#include "template_module.hpp"

#include <iostream>

/// @brief Run the sample template application.
/// @return Exit status code for the process.
int main()
{
  std::cout << template_repo::BuildGreeting("OHC") << "\n";
  return 0;
}
