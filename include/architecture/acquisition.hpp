/// @file      acquisition.hpp
/// @namespace template_repo::input
/// @brief     Input acquisition module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This module handles the first stage of the architecture pipeline:
///            acquiring and normalizing raw input from various sources.
///            It provides a standardized structure for acquired input data.

#pragma once

#include <string>

namespace template_repo::input
{

  /// @brief Structure representing acquired and normalized input data.
  /// @details Contains the processed input value and metadata about its source.
  struct AcquiredInput
  {
      /// @brief The normalized input value (trimmed of whitespace).
      std::string value;

      /// @brief The source identifier for this input (e.g., "user_input", "file", "network").
      std::string source;
  };

  /// @brief Acquire and normalize input from a raw string value.
  /// @param raw_value The raw input string to acquire and normalize.
  /// @return AcquiredInput structure with trimmed value and source metadata.
  /// @details This function performs the first stage of the architecture pipeline:
  ///          1. Takes a raw string input
  ///          2. Trims leading/trailing whitespace using common::Trim()
  ///          3. Returns structured data with source tracking
  ///          The source is hardcoded to "user_input" in this template implementation.
  AcquiredInput AcquireInput(const std::string& raw_value);

} // namespace template_repo::input
