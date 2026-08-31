/// @file      output.cpp
/// @namespace template_repo::output
/// @brief     Output definition implementation.

#include "architecture/output.hpp"

namespace template_repo::output
{

OutputMessage BuildOutput(const processing::ProcessedInput& processed_input)
{
  if (processed_input.value.empty())
  {
    return {"Hello from OHC template repo", "stdout"};
  }

  return {"Hello " + processed_input.value + " from OHC template repo", "stdout"};
}

} // namespace template_repo::output
