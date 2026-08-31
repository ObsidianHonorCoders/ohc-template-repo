/// @file      processing.hpp
/// @namespace template_repo::processing
/// @brief     Processing module for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#pragma once

#include <string>

#include "architecture/acquisition.hpp"

namespace template_repo::processing
{

  struct ProcessedInput
  {
      std::string value;
      std::string stage;
  };

  ProcessedInput ProcessInput(const input::AcquiredInput& acquired_input);

} // namespace template_repo::processing
