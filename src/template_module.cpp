#include "template_module.hpp"

namespace template_repo
{

  std::string BuildGreeting(const std::string& name)
  {
    if (name.empty())
    {
      return "Hello from OHC template repo";
    }

    return "Hello " + name + " from OHC template repo";
  }

} // namespace template_repo
