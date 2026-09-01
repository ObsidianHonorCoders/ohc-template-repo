/// @file      test_template_module.cpp
/// @namespace template_repo
/// @brief     Unit tests for the acquisition, processing, output, and compatibility
///            modules.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#include "compatibility_api.hpp"

#include <gtest/gtest.h>

TEST(ArchitectureUnitTests, AcquisitionNormalizesInput)
{
  const auto input = template_repo::input::AcquireInput("  OHC  ");

  EXPECT_EQ("OHC", input.value);
  EXPECT_EQ("user_input", input.source);
}

TEST(ArchitectureUnitTests, ProcessingTransformsInput)
{
  const auto input  = template_repo::input::AcquireInput("ohc");
  const auto result = template_repo::processing::ProcessInput(input);

  EXPECT_EQ("ohc", result.value);
  EXPECT_EQ("processed", result.stage);
}

TEST(ArchitectureUnitTests, OutputBuildsHumanReadableMessage)
{
  const auto input     = template_repo::input::AcquireInput("OHC");
  const auto processed = template_repo::processing::ProcessInput(input);
  const auto output    = template_repo::output::BuildOutput(processed);

  EXPECT_EQ("Hello OHC from OHC template repo", output.message);
  EXPECT_EQ("stdout", output.destination);
}

TEST(CompatibilityApiTests, BuildGreetingWithName) { EXPECT_EQ("Hello OHC from OHC template repo", template_repo::BuildGreeting("OHC")); }

TEST(CompatibilityApiTests, BuildGreetingWithEmptyName) { EXPECT_EQ("Hello from OHC template repo", template_repo::BuildGreeting("")); }
