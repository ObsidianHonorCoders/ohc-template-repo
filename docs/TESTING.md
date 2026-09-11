# Testing Guide

This project uses [Google Test (GTest)](
https://github.com/google/googletest) for unit and integration testing.

## Test Organization

Tests are located in `tests/` with two categories:

```
tests/
├── unit/
│   └── test_template_module.cpp    # Component-level tests
└── integration/
    └── test_pipeline.cpp           # End-to-end workflow tests
```

### Unit Tests

Test individual components in isolation.

**When to use**: Testing a single class, function, or module
**Characteristics**: Fast, deterministic, minimal dependencies
**Example**: `test_template_module.cpp` tests each architecture
layer separately (acquisition, processing, output)

### Integration Tests

Test complete workflows with multiple components working together.

**When to use**: Verifying the full pipeline or user-visible
behavior
**Characteristics**: Slower, end-to-end, real dependencies
**Example**: `test_pipeline.cpp` tests input→process→output
chain

## Running Tests

### Run All Tests

```bash
# After building
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
```

### Run Specific Test

```bash
# By test name
ctest --preset dev-test -R ArchitectureUnitTests \
  --output-on-failure

# By executable
./build/dev/bin/test_ohc_template_app --gtest_filter=\
BuildGreetingWithName
```

### Verbose Output

```bash
ctest --preset dev-test --output-on-failure -VV
```

## Writing Tests

### Basic Unit Test Structure

```cpp
#include "module_under_test.hpp"
#include <gtest/gtest.h>

// TEST(TestSuiteName, TestName)
TEST(ArchitectureUnitTests, FunctionDoesExpectedThing)
{
  // Arrange: Set up test data
  const auto input = prepare_input("test_value");

  // Act: Call the function under test
  const auto result = function_under_test(input);

  // Assert: Verify results
  EXPECT_EQ(expected_output, result.value);
  EXPECT_EQ("expected_status", result.status);
}
```

### Naming Conventions

**Suite name**: PascalCase, descriptive
- `ArchitectureUnitTests`
- `CompatibilityApiTests`
- `EndToEndTests`

**Test name**: PascalCase, describes what it tests
- `AcquisitionNormalizesInput`
- `BuildGreetingWithName`
- `EndToEndPipelineProducesGreeting`

### Common Assertions

```cpp
// Equality
EXPECT_EQ(expected, actual);
ASSERT_EQ(expected, actual);  // Stop on failure

// Comparison
EXPECT_LT(actual, limit);      // Less than
EXPECT_LE(actual, limit);      // Less or equal
EXPECT_GT(actual, limit);      // Greater than
EXPECT_GE(actual, limit);      // Greater or equal

// Boolean
EXPECT_TRUE(condition);
EXPECT_FALSE(condition);

// String matching
EXPECT_STREQ("expected", actual_c_str);
EXPECT_THAT(str, testing::HasSubstr("substring"));

// Exception testing
EXPECT_THROW(function(), ExceptionType);
```

For complete reference, see
[GTest Assertions](https://google.github.io/googletest/reference/
assertions.html).

## Adding a New Test File

1. Create file in appropriate directory:
   ```
   tests/unit/test_my_module.cpp
   ```

2. Include headers:
   ```cpp
   #include "my_module.hpp"
   #include <gtest/gtest.h>
   ```

3. Write tests following naming conventions

4. CMake auto-discovers tests via `gtest_discover_tests()`
   - No need to modify CMakeLists.txt
   - Just write the test file

## Test Dependencies

GoogleTest is automatically downloaded via FetchContent in
CMakeLists.txt. No manual installation needed.

**Version**: v1.14.0 (pinned in CMakeLists.txt)
**Update**: Change `GIT_TAG` in CMakeLists.txt to new version

## Continuous Integration

All tests run in GitHub Actions on:
- Linux (GCC + Clang)
- Windows (MSVC + MinGW)
- macOS (Clang)

Tests must pass in both Debug and Release builds.

## Best Practices

1. **Test isolation**: Each test should be independent
2. **Descriptive names**: Test name should explain what it tests
3. **One assertion per test**: Generally; multiple for related
   values OK
4. **Avoid test interdependence**: Don't rely on test execution
   order
5. **Mock external dependencies**: Use GTest mocks for I/O,
   databases
6. **Keep tests fast**: Slow tests discourage running locally
7. **Deterministic**: Tests should always pass or always fail,
   no flakiness

## Mocking with GTest

For testing code that depends on external systems:

```cpp
#include <gmock/gmock.h>

// Define mock class
class MockInputReader {
 public:
  MOCK_METHOD(std::string, ReadInput, ());
};

// Use in test
TEST(MyTest, WithMock)
{
  MockInputReader mock_reader;
  EXPECT_CALL(mock_reader, ReadInput())
    .WillOnce(testing::Return("test_input"));

  // Now use mock_reader in your code...
}
```

See [GTest Mocking](https://google.github.io/googletest/
gmock_for_dummies.html) for details.

## Coverage Analysis

Generate code coverage reports:

```bash
cmake -S . -B build -DENABLE_COVERAGE=ON
cmake --build build
ctest --preset dev-test
lcov --directory build --capture --output-file coverage.info
genhtml coverage.info --output-directory coverage
open coverage/index.html
```

See [CMAKE_OPTIONS.md](CMAKE_OPTIONS.md) for coverage options.

## Troubleshooting

**"Test not found"**: Ensure file is in `tests/` and follows
naming patterns

**"GTest download failed"**: Check internet connection; see
[CMAKE_OPTIONS.md](CMAKE_OPTIONS.md)

**"Assertion failed"**: Check expected vs actual values; add
debug output with `std::cout` or GTest logging

**"Flaky test"**: Test may have race condition or external
dependency issue; check for shared state

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more.
