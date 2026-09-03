/// @file      compatibility_api.hpp
/// @namespace template_repo
/// @brief     Compatibility facade for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This header provides a unified interface to the architecture layer,
///            combining input acquisition, processing, and output generation into
///            a single convenient function for easy integration.

#pragma once

#include "architecture/acquisition.hpp"
#include "architecture/output.hpp"
#include "architecture/processing.hpp"

#include <string>

namespace template_repo
{

  /// @brief Build a greeting message using the full architecture pipeline.
  /// @param name The name to include in the greeting (will be trimmed).
  /// @return A formatted greeting string from the architecture layer.
  /// @details This function chains the complete architecture pipeline:
  ///          1. Acquires input using input::AcquireInput()
  ///          2. Processes it using processing::ProcessInput()
  ///          3. Generates output using output::BuildOutput()
  ///          The name parameter is automatically trimmed of whitespace.
  std::string BuildGreeting(const std::string& name);

} // namespace template_repo
