/// @file      main.cpp
/// @namespace template_repo
/// @brief     Entry point for the enterprise-style sample application.

#include "compatibility_api.hpp"

#include <iostream>

int main()
{
  std::cout << template_repo::BuildGreeting("  OHC  ") << "\n";
  return 0;
}
