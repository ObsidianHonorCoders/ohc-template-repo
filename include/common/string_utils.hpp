/// @file      string_utils.hpp
/// @namespace template_repo::common
/// @brief     Reusable helpers for the sample enterprise-style codebase.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This module provides common string manipulation utilities used
///            throughout the architecture pipeline. Currently provides whitespace
///            trimming functionality for input normalization.

#pragma once

#include <string>

namespace template_repo::common
{

  /// @brief Remove leading and trailing whitespace from a string.
  /// @param value The string value to normalize.
  /// @return A new string with leading and trailing whitespace removed.
  /// @details This function removes all leading and trailing whitespace characters
  ///          including spaces, tabs, carriage returns, and newlines.
  ///          If the string contains only whitespace, an empty string is returned.
  ///          Internal whitespace is preserved.
  /// @code
  /// std::string result = template_repo::common::Trim("  hello world  ");
  /// // result == "hello world"
  /// @endcode
  std::string Trim(const std::string& value);

} // namespace template_repo::common
