/// @file      output.hpp
/// @namespace template_repo::output
/// @brief     Output module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This module handles the final stage of the architecture pipeline:
///            generating formatted output messages from processed input data.
///            It provides a standardized structure for output messages with destination tracking.

#pragma once

#include <string>

#include "architecture/processing.hpp"

namespace template_repo::output
{

  /// @brief Structure representing a formatted output message.
  /// @details Contains the generated message and its intended destination.
  struct OutputMessage
  {
      /// @brief The formatted output message string.
      std::string message;

      /// @brief The destination identifier for this output (e.g., "stdout", "file", "network").
      std::string destination;
  };

  /// @brief Build an output message from processed input data.
  /// @param processed_input The processed input containing value and stage information.
  /// @return OutputMessage structure with formatted message and destination.
  /// @details This function performs the final stage of the architecture pipeline:
  ///          1. Takes processed input from processing::ProcessInput()
  ///          2. Generates a greeting message based on the processed value
  ///          3. Returns structured output with destination tracking
  ///          If the processed value is empty, returns a default greeting.
  ///          The destination is hardcoded to "stdout" in this template implementation.
  OutputMessage BuildOutput(const processing::ProcessedInput& processed_input);

} // namespace template_repo::output
