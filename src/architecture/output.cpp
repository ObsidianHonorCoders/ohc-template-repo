/// @file      output.cpp
/// @namespace template_repo::output
/// @brief     Output definition implementation.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   This file implements the output generation stage of the architecture pipeline.
///            It creates formatted greeting messages from processed input data.

#include "architecture/output.hpp"

namespace template_repo::output
{

  OutputMessage BuildOutput(const processing::ProcessedInput& processed_input)
  {
    // Generate appropriate greeting based on processed input
    std::string message;

    if (processed_input.value.empty())
    {
      // Default greeting when no name provided
      message = "Hello from OHC template repo";
    }
    else
    {
      // Personalized greeting with the processed name
      message = "Hello " + processed_input.value + " from OHC template repo";
    }

    // Return structured output with destination tracking
    return {message, "stdout"};
  }

} // namespace template_repo::output
