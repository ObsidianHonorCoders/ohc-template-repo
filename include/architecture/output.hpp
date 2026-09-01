/// @file      output.hpp
/// @namespace template_repo::output
/// @brief     Output module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#pragma once

#include <string>

#include "architecture/processing.hpp"

namespace template_repo::output
{

  struct OutputMessage
  {
      std::string message;
      std::string destination;
  };

  OutputMessage BuildOutput(const processing::ProcessedInput& processed_input);

} // namespace template_repo::output
