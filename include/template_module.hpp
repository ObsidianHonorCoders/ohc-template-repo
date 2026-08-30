/// @file      template_module.hpp
/// @namespace template_repo
/// @brief     OHC template module public interface.
/// @author    Calileus
/// @date      2026-08-30
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   Declares the public API for the sample template module used by
///            the application and its unit tests.

#pragma once

#include <string>

namespace template_repo
{

  /// @brief Build a greeting string for the supplied name.
  /// @param name User name to include in the greeting.
  /// @return Greeting string that includes the template repository branding.
  std::string BuildGreeting(const std::string& name);

} // namespace template_repo
