/// @file      processing.hpp
/// @namespace template_repo::processing
/// @brief     Processing module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This module handles the middle stage of the architecture pipeline:
///            transforming acquired input into processed data ready for output generation.
///            It provides a standardized structure for processed input data with stage tracking.

#pragma once

#include <string>

#include "architecture/acquisition.hpp"

namespace template_repo::processing
{

  /// @brief Structure representing processed input data.
  /// @details Contains the transformed input value and the processing stage identifier.
  struct ProcessedInput
  {
      /// @brief The processed input value (passed through from acquired input).
      std::string value;

      /// @brief The processing stage identifier (e.g., "processed", "validated", "transformed").
      std::string stage;
  };

  /// @brief Process acquired input into structured data for output generation.
  /// @param acquired_input The acquired input containing normalized value and source.
  /// @return ProcessedInput structure with value and processing stage metadata.
  /// @details This function performs the middle stage of the architecture pipeline:
  ///          1. Takes acquired input from input::AcquireInput()
  ///          2. Passes the value through with a stage identifier
  ///          3. Returns structured data for the output module
  ///          The stage is hardcoded to "processed" in this template implementation.
  ProcessedInput ProcessInput(const input::AcquiredInput& acquired_input);

} // namespace template_repo::processing
