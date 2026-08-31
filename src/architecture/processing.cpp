/// @file      processing.cpp
/// @namespace template_repo::processing
/// @brief     Processing implementation.

#include "architecture/processing.hpp"

namespace template_repo::processing
{

  ProcessedInput ProcessInput(const input::AcquiredInput& acquired_input) { return {acquired_input.value, "processed"}; }

} // namespace template_repo::processing
