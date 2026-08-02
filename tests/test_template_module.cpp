#include "template_module.hpp"

#include <iostream>
#include <string>

namespace
{

  int AssertEqual(const std::string& expected, const std::string& actual, const char* test_name)
  {
    if (expected == actual)
    {
      return 0;
    }

    std::cerr << "[FAIL] " << test_name << "\n"
              << "  expected: " << expected << "\n"
              << "  actual:   " << actual << "\n";
    return 1;
  }

} // namespace

int RunTemplateModuleTests()
{
  int failures = 0;

  failures += AssertEqual("Hello OHC from OHC template repo", template_repo::BuildGreeting("OHC"), "BuildGreeting with name");

  failures += AssertEqual("Hello from OHC template repo", template_repo::BuildGreeting(""), "BuildGreeting with empty name");

  return failures;
}
