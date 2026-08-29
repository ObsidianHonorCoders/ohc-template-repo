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

include(GoogleTest)
gtest_discover_tests(test_${EXE_NAME}
  EXTRA_ARGS --gtest_brief=1
  PROPERTIES TIMEOUT 30
)
