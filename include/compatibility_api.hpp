/// @file      compatibility_api.hpp
/// @namespace template_repo
/// @brief     Compatibility facade for the enterprise-style architecture layer.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#pragma once

#include "architecture/acquisition.hpp"
#include "architecture/output.hpp"
#include "architecture/processing.hpp"

#include <string>

namespace template_repo
{

  std::string BuildGreeting(const std::string& name);

} // namespace template_repo
