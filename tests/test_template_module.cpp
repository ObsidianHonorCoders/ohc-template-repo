/// @file      test_template_module.cpp
/// @namespace template_repo
/// @brief     Unit tests for the OHC template module.
/// @author    Calileus
/// @date      2026-08-30
/// @copyright 2026 Obsidian Honor Coders. Licensed under Apache 2.0.
/// @see       https://github.com/ObsidianHonorCoders/ohc-template-repo
/// @details   Verifies the greeting output for both populated and empty names.

#include "template_module.hpp"

#include <gtest/gtest.h>

/// @brief Verify the greeting includes the provided name and repository branding.
TEST(TemplateModuleTests, BuildGreetingWithName) { EXPECT_EQ("Hello OHC from OHC template repo", template_repo::BuildGreeting("OHC")); }

/// @brief Verify the greeting falls back to the default repository message.
TEST(TemplateModuleTests, BuildGreetingWithEmptyName) { EXPECT_EQ("Hello from OHC template repo", template_repo::BuildGreeting("")); }
