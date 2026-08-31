# Test executable
add_executable(test_${EXE_NAME}
  test_template_module.cpp
)

target_include_directories(test_${EXE_NAME}
  PRIVATE
    ${CMAKE_SOURCE_DIR}/include
)

target_link_libraries(test_${EXE_NAME}
  PRIVATE
    template_module
    GTest::gtest_main
)

add_test(
  NAME rename_template_dry_run
  COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/rename-template.sh MyProject --dry-run --yes --author "Jane Doe" --email "jane@example.com" --github-owner "janedoe"
)
set_tests_properties(rename_template_dry_run PROPERTIES
  PASS_REGULAR_EXPRESSION "Dry run|No files were modified"
  TIMEOUT 30
)

include(GoogleTest)
gtest_discover_tests(test_${EXE_NAME}
  EXTRA_ARGS --gtest_brief=1
  PROPERTIES TIMEOUT 30
)
