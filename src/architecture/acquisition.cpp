/// @file      acquisition.cpp
/// @namespace template_repo::input
/// @brief     Input acquisition implementation.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This file implements the input acquisition stage of the architecture pipeline.
///            It normalizes raw input by trimming whitespace and attaches source metadata.

#include "architecture/acquisition.hpp"

#include "common/string_utils.hpp"

namespace template_repo::input
{

  AcquiredInput AcquireInput(const std::string& raw_value)
  {
    // Normalize the input by trimming whitespace
    const std::string normalized_value = common::Trim(raw_value);

    // Return structured acquired input with source tracking
    return {normalized_value, "user_input"};
  }

} // namespace template_repo::input
