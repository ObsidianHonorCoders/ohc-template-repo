/// @file      compatibility_api.cpp
/// @namespace template_repo
/// @brief     Compatibility façade implementation for the architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#include "compatibility_api.hpp"

namespace template_repo
{

std::string BuildGreeting(const std::string& name)
{
  const auto acquired_input = input::AcquireInput(name);
  const auto processed_input = processing::ProcessInput(acquired_input);
  return output::BuildOutput(processed_input).message;
}

} // namespace template_repo
