/// @file      acquisition.hpp
/// @namespace template_repo::input
/// @brief     Input acquisition module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#pragma once

#include <string>

namespace template_repo::input
{

  struct AcquiredInput
  {
      std::string value;
      std::string source;
  };

  AcquiredInput AcquireInput(const std::string& raw_value);

} // namespace template_repo::input
