# @file    build_and_run_project.cmake @brief   Cross-platform CMake build and
# execution script @details Comprehensive build automation script that
# configures, compiles, and runs a CMake-based C++ project across multiple
# platforms (Windows, Linux, macOS). The script automatically detects the host
# platform, available compilers, and system resources (CPU cores) to optimize
# the build process.
#
# @section workflow Workflow -# Calls detect_generator.cmake to get: -
# DETECTED_PLATFORM: The string name of the detected operating system. -
# DETECTED_ARCH:     The detected bit-depth of the host system. - NUM_CORES: The
# detected available processor cores amount. - GENERATOR:         The detected
# generator candidate. -# Configures the project with CMake (Release build by
# default) -# Builds the project using all available CPU cores in parallel -#
# Runs the compiled executable -# Reports build status and execution results
#
# @section features Features - **Cross-platform Support**:   Works seamlessly
# across different operating systems - **Generator Selection**:      Chooses
# available build system (Ninja, MinGW, VS) - **Parallel Compilation**:     Uses
# all system CPU cores to maximize build speed - **Error Handling**: Graceful
# error reporting at each build stage - **Automatic Execution Test**: Runs
# platform-specific compiled binary after successful build - **Test
# Integration**:         Optional test building and execution
#
# @section platforms Supported Platforms & Generators | Platform | Default |
# Fallback 1      | Fallback 2     |
# |----------|-----------------|-----------------|----------------|
# | Windows  | Ninja           | MinGW Makefiles | Visual Studio  | | Linux    |
# Ninja           | System Default  | -              | | macOS    | Ninja |
# System Default  | -              |
#
# @section usage Usage @code cmake -P build_and_run_project.cmake cmake
# -DBUILD_TESTS=ON -P build_and_run_project.cmake cmake -DCMAKE_BUILD_TYPE=Debug
# -P build_and_run_project.cmake @endcode
#
# @section configuration Configuration Edit the following variables at the
# beginning of the script to customize: - `EXE_NAME`:  Name of the executable to
# build      (default: PROJECT_NAME_app) - `BUILD_DIR`: Output directory for
# build artifacts (default: build) - `BUILD_TYPE`: Build type (Release, Debug,
# RelWithDebInfo, MinSizeRel) - `BUILD_TESTS`: Build and run tests (ON/OFF)
#
# @section requirements Requirements - CMake 3.25 or higher - A C/C++ compiler
# (GCC, Clang, MSVC, etc.) - At least one build system generator available
#
# @section performance Performance Optimization This script maximizes build
# performance by: - Utilizing all available CPU cores for parallel compilation -
# Using Release build configuration for optimized binaries by default -
# Displaying compilation progress in real-time
#
# @author  Calileus @version 2.0 @date    2026-08-29

cmake_minimum_required(VERSION 3.25)

# @var     CMAKE_BUILD_TYPE @brief   Build configuration type @details Defaults
# to Release for optimized binaries
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE
      "Release"
      CACHE STRING "Build type" FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
                                             "RelWithDebInfo" "MinSizeRel")

# @var     EXE_NAME @brief   Name of the executable to build @details Defaults
# to project name with _app suffix
if(NOT DEFINED EXE_NAME)
  set(EXE_NAME
      "${PROJECT_NAME}_app"
      CACHE STRING "Executable name" FORCE)
endif()

# @var     BUILD_DIR @brief   Output directory for build artifacts @details All
# build files and the executable will be placed here
set(BUILD_DIR
    "build"
    CACHE STRING "Build directory" FORCE)

# @var     BUILD_TESTS @brief   Option to build and run tests @details Set to ON
# to build and run tests
option(BUILD_TESTS "Build and run tests" ON)

# @section exe_location Executable Path Resolution @brief Constructs the path to
# the compiled executable Accounts for platform differences: .exe on Windows,
# bare name on Unix
if(WIN32)
  set(EXE_PATH "${BUILD_DIR}/${EXE_NAME}.exe")
else()
  set(EXE_PATH "${BUILD_DIR}/${EXE_NAME}")
endif()

# @section folderclean CMake Previous Build folder cleaning @brief Erase the
# build folder if it exists
if(EXISTS "${BUILD_DIR}")
  message(STATUS "Cleaning: Removing old build directory...")
  file(REMOVE_RECURSE "${BUILD_DIR}")
endif()
file(MAKE_DIRECTORY "${BUILD_DIR}")

# @section detect_generator Generator Detection -# Calls detect_generator.cmake
# to get: - DETECTED_PLATFORM: The string name of the detected operating system.
# - DETECTED_ARCH:     The detected bit-depth of the host system. - NUM_CORES:
# The detected available processor cores amount. - GENERATOR:         The
# detected generator candidate.
include(cmakehelpers/detect_generator.cmake)

# @section config CMake Configuration @brief          Runs cmake to generate
# platform-specific build files
message(STATUS "Build Type:    ${CMAKE_BUILD_TYPE}")
message(STATUS "Build Dir:     ${BUILD_DIR}/")
message(STATUS "Executable:    ${EXE_PATH}")
message("")
message(
  "======= CMake Configuration Phase ============================================="
)

# @var   CONF_ARGS @brief Arguments passed to cmake configuration Includes:
# build directory (-B), build type, executable name, test option Append:
# generator argument if one was automatically selected
set(CONF_ARGS -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
              -DEXE_NAME=${EXE_NAME} -DBUILD_TESTS=${BUILD_TESTS})
if(NOT "${GENERATOR}" STREQUAL "")
  list(APPEND CONF_ARGS -G "${GENERATOR}")
endif()

# @brief Execute CMake configuration
execute_process(COMMAND ${CMAKE_COMMAND} ${CONF_ARGS}
                RESULT_VARIABLE CONFIG_RESULT)

# @brief Check configuration result and abort on failure with helpful
# diagnostics
if(NOT CONFIG_RESULT EQUAL 0)
  message(
    FATAL_ERROR
      "CMAKE CONFIGURATION FAILED
 This likely means:
 - Your C/C++ compiler is not in the system PATH
 - CMake could not find the compiler for the selected generator
 - There's an error in your CMakeLists.txt file
 Please ensure you have a compatible working compiler installed:
 - Windows: Visual Studio, GCC (MinGW), or Clang
 - Linux: GCC or Clang
 - macOS: Xcode Command Line Tools (clang)")
endif()
message(STATUS "Configuration completed successfully")

# @section build_exec Build with Parallel Compilation @brief Compiles the
# project using all detected CPU cores The --parallel flag is critical for
# utilizing multi-core systems
message("")
message(
  "======= CMake Parallel Build Phase ============================================"
)

# @brief Validate core count and ensure minimum of 1
if(NOT NUM_CORES GREATER_EQUAL 1)
  set(NUM_CORES 1)
endif()

# @var   BUILD_COMMAND_ARGS @brief Arguments for cmake --build command
set(BUILD_COMMAND_ARGS --build ${BUILD_DIR} --config ${CMAKE_BUILD_TYPE}
                       --parallel ${NUM_CORES})
message(STATUS "Building with ${NUM_CORES} parallel cores...")

# @brief Execute the build with parallel compilation across all CPU cores @note
# Build progress and compiler output is displayed in real-time
execute_process(COMMAND ${CMAKE_COMMAND} ${BUILD_COMMAND_ARGS}
                RESULT_VARIABLE BUILD_RESULT)

# @brief Check build result and abort on failure
if(NOT BUILD_RESULT EQUAL 0)
  message(FATAL_ERROR "BUILD FAILED with BUILD_RESULT ${BUILD_RESULT}")
endif()
message(STATUS "Build completed successfully using all ${NUM_CORES} CPU cores")

# @section test_exec Test Executable Location and Verification @brief Verify
# expected executable location and run it
message("")
message(
  "======= Google Test Running Phase ============================================="
)
if(BUILD_TESTS)
  message("Starting tests...")
  # Test executable follows CMake project naming convention
  if(WIN32)
    set(TEST_EXE_PATH "${BUILD_DIR}/tests/${PROJECT_NAME}_tests.exe")
  else()
    set(TEST_EXE_PATH "${BUILD_DIR}/tests/${PROJECT_NAME}_tests")
  endif()
  if(EXISTS ${TEST_EXE_PATH})
    execute_process(COMMAND ${TEST_EXE_PATH} RESULT_VARIABLE TEST_RESULT)
    if(NOT TEST_RESULT EQUAL 0)
      message(WARNING "Tests failed!")
    else()
      message(STATUS "All tests passed!")
    endif()
  else()
    message(WARNING "Test executable not found at: ${TEST_EXE_PATH}")
    message(
      STATUS "This is normal if tests are not configured or built separately.")
  endif()
else()
  message("Tests disabled, skipping test execution...")
endif()

# @section bin_exec Executable Location and Verification @brief Verify expected
# executable location and run it
message("")
message(
  "======= Binary Executable Running Phase ======================================="
)
message(STATUS "Looking for executable at: ${EXE_PATH}")

# @brief Verify executable exists before attempting execution
if(EXISTS ${EXE_PATH})
  message(STATUS "Executable found, launching...")
  message(
    "==============================================================================="
  )
  # @section exec_run Program Execution @brief Runs the compiled executable and
  # captures exit code
  execute_process(COMMAND ${EXE_PATH} RESULT_VARIABLE RUN_RESULT)
  message(
    "==============================================================================="
  )

  # @brief Report execution status
  if(RUN_RESULT EQUAL 0)
    message(STATUS "Application executed successfully (exit code: 0)")
  else()
    message(WARNING "Application exited with code: ${RUN_RESULT}")
  endif()
else()
  message(FATAL_ERROR "EXECUTABLE NOT FOUND at: ${EXE_PATH}")
endif()

message("Thanks for using build_and_run_project.cmake script!")
message("")
