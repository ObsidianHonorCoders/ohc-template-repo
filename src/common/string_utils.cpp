/// @file      string_utils.cpp
/// @namespace template_repo::common
/// @brief     Shared utility implementations.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This file implements common string manipulation utilities used
///            throughout the architecture pipeline for input normalization.

#include "common/string_utils.hpp"

namespace template_repo::common
{

  std::string Trim(const std::string& value)
  {
    // Find the first non-whitespace character
    const auto begin = value.find_first_not_of(" \t\r\n");
    
    // If string is all whitespace, return empty string
    if (begin == std::string::npos)
    {
      return {};
    }

    // Find the last non-whitespace character
    const auto end = value.find_last_not_of(" \t\r\n");
    
    // Extract and return the trimmed substring
    return value.substr(begin, end - begin + 1);
  }

} // namespace template_repo::common
