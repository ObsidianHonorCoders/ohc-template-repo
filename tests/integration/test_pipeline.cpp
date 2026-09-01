/// @file      test_pipeline.cpp
/// @namespace template_repo
/// @brief     Integration tests for the complete architecture flow.
/// @author    Calileus
/// @date      2026-08-31
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.

#include "compatibility_api.hpp"

#include <gtest/gtest.h>

TEST(ArchitectureIntegrationTests, EndToEndPipelineProducesGreeting)
{
  const auto acquired_input  = template_repo::input::AcquireInput("  OHC  ");
  const auto processed_input = template_repo::processing::ProcessInput(acquired_input);
  const auto output          = template_repo::output::BuildOutput(processed_input);

  EXPECT_EQ("Hello OHC from OHC template repo", output.message);
  EXPECT_EQ("stdout", output.destination);
}
