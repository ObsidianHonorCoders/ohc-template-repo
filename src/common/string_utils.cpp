/// @file      string_utils.cpp
/// @namespace template_repo::common
/// @brief     Shared utility implementations.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#include "common/string_utils.hpp"

namespace template_repo::common
{

  std::string Trim(const std::string& value)
  {
    const auto begin = value.find_first_not_of(" \t\r\n");
    if (begin == std::string::npos)
    {
      return {};
    }

    const auto end = value.find_last_not_of(" \t\r\n");
    return value.substr(begin, end - begin + 1);
  }

} // namespace template_repo::common
