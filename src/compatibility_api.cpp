/// @file      compatibility_api.cpp
/// @namespace template_repo
/// @brief     Compatibility façade implementation for the architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This file implements the unified interface to the architecture layer,
///            chaining the complete pipeline: input acquisition -> processing -> output generation.

#include "compatibility_api.hpp"

namespace template_repo
{

  std::string BuildGreeting(const std::string& name)
  {
    // Stage 1: Acquire and normalize input
    const auto acquired_input = input::AcquireInput(name);

    // Stage 2: Process the acquired input
    const auto processed_input = processing::ProcessInput(acquired_input);

    // Stage 3: Generate output from processed input
    return output::BuildOutput(processed_input).message;
  }

} // namespace template_repo
