/// @file      template_module.cpp
/// @namespace template_repo
/// @brief     Implementation for the OHC template module.
/// @author    Calileus
/// @date      2026-08-30
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   Provides the concrete implementation of the sample greeting
///            utility used by the executable and tests.

#include "template_module.hpp"

namespace template_repo
{

  /// @brief Build a greeting string for the supplied name.
  /// @param name User name to include in the greeting.
  /// @return Greeting string that includes the template repository branding.
  std::string BuildGreeting(const std::string& name)
  {
    if (name.empty())
    {
      return "Hello from OHC template repo";
    }

    return "Hello " + name + " from OHC template repo";
  }

} // namespace template_repo
