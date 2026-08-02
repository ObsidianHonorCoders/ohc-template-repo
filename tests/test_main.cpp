#include <exception>
#include <iostream>

int RunTemplateModuleTests();

int main()
{
  try
  {
    const int failures = RunTemplateModuleTests();
    if (failures != 0)
    {
      std::cerr << "Test failures: " << failures << "\n";
      return 1;
    }
    std::cout << "All tests passed\n";
    return 0;
  }
  catch (const std::exception& ex)
  {
    std::cerr << "Unhandled test exception: " << ex.what() << "\n";
    return 1;
  }
}
