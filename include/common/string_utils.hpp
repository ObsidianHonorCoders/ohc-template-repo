/// @file      string_utils.hpp
/// @namespace template_repo::common
/// @brief     Reusable helpers for the sample enterprise-style codebase.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#pragma once

#include <string>

namespace template_repo::common
{

  /// @brief Remove leading and trailing whitespace from a string.
  /// @param value Value to normalize.
  /// @return Trimmed value.
  std::string Trim(const std::string& value);

} // namespace template_repo::common
