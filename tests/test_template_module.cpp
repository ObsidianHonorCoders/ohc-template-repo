#include "template_module.hpp"

#include <gtest/gtest.h>

TEST(TemplateModuleTests, BuildGreetingWithName)
{
    EXPECT_EQ("Hello OHC from OHC template repo", template_repo::BuildGreeting("OHC"));
}

TEST(TemplateModuleTests, BuildGreetingWithEmptyName)
{
    EXPECT_EQ("Hello from OHC template repo", template_repo::BuildGreeting(""));
}
