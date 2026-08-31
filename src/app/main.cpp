/// @file      main.cpp
/// @namespace template_repo
/// @brief     Entry point for the enterprise-style sample application.

#include "architecture/acquisition.hpp"
#include "architecture/output.hpp"
#include "architecture/processing.hpp"

#include <iostream>

int main()
{
  const auto acquired_input  = template_repo::input::AcquireInput("  OHC  ");
  const auto processed_input = template_repo::processing::ProcessInput(acquired_input);
  const auto result          = template_repo::output::BuildOutput(processed_input);

  std::cout << result.message << "\n";
  return 0;
}
