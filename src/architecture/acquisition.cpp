/// @file      acquisition.cpp
/// @namespace template_repo::input
/// @brief     Input acquisition implementation.

#include "architecture/acquisition.hpp"

#include "common/string_utils.hpp"

namespace template_repo::input
{

AcquiredInput AcquireInput(const std::string& raw_value)
{
  return {common::Trim(raw_value), "user_input"};
}

} // namespace template_repo::input
