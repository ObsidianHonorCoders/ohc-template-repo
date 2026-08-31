# Quick local build-and-run helper for CMake projects.
#
# This script is intended for a fast developer workflow:
#   1. Detect the host OS, architecture, CPU count, and generator.
#   2. Remove any stale build output in the local build directory.
#   3. Configure the project with CMake.
#   4. Build using parallel compilation.
#   5. Optionally run the test suite.
#   6. Run the executable.
#
# Typical usage:
#   cmake -P cmakehelpers/quick_build.cmake
#   cmake -DCMAKE_BUILD_TYPE=Debug -P cmakehelpers/quick_build.cmake
#   cmake -DBUILD_TESTS=OFF -P cmakehelpers/quick_build.cmake
#   cmake -DEXE_NAME=myapp -P cmakehelpers/quick_build.cmake
#
# Configuration variables:
#   CMAKE_BUILD_TYPE   - Debug/Release/RelWithDebInfo/MinSizeRel
#   EXE_NAME           - Executable name to run (default: ${PROJECT_NAME}_app)
#   BUILD_DIR          - Output folder used for generated build files (default: build)
#   BUILD_TESTS        - Whether to build and execute tests (default: ON)
#
# Notes:
#   - build/ is a conventional local artifact directory. Keeping it at the repo
#     root is normal for a small project and makes it easy to inspect artifacts.
#   - This is a convenience script for local builds; regular development should
#     prefer the repo's CMake presets where available.
#
# Author: Calileus
# Version: 2.0
# Date: 2026-08-29

cmake_minimum_required(VERSION 3.25)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo" "MinSizeRel")

if(NOT DEFINED EXE_NAME)
  set(EXE_NAME "${PROJECT_NAME}_app" CACHE STRING "Executable name" FORCE)
endif()

set(BUILD_DIR "build" CACHE STRING "Build directory" FORCE)
option(BUILD_TESTS "Build and run tests" ON)

if(WIN32)
  set(EXE_PATH "${BUILD_DIR}/${EXE_NAME}.exe")
else()
  set(EXE_PATH "${BUILD_DIR}/${EXE_NAME}")
endif()

if(EXISTS "${BUILD_DIR}")
  message(STATUS "Cleaning: removing old build directory...")
  file(REMOVE_RECURSE "${BUILD_DIR}")
endif()
file(MAKE_DIRECTORY "${BUILD_DIR}")

include(${CMAKE_CURRENT_LIST_DIR}/detect_generator.cmake)

message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Build Dir:  ${BUILD_DIR}/")
message(STATUS "Executable: ${EXE_PATH}")

set(CONF_ARGS -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DEXE_NAME=${EXE_NAME} -DBUILD_TESTS=${BUILD_TESTS})
if(NOT "${GENERATOR}" STREQUAL "")
  list(APPEND CONF_ARGS -G "${GENERATOR}")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} ${CONF_ARGS} RESULT_VARIABLE CONFIG_RESULT)
if(NOT CONFIG_RESULT EQUAL 0)
  message(FATAL_ERROR "CMake configure failed.")
endif()

if(NOT NUM_CORES GREATER_EQUAL 1)
  set(NUM_CORES 1)
endif()

set(BUILD_COMMAND_ARGS --build ${BUILD_DIR} --config ${CMAKE_BUILD_TYPE} --parallel ${NUM_CORES})
message(STATUS "Building with ${NUM_CORES} cores...")
execute_process(COMMAND ${CMAKE_COMMAND} ${BUILD_COMMAND_ARGS} RESULT_VARIABLE BUILD_RESULT)
if(NOT BUILD_RESULT EQUAL 0)
  message(FATAL_ERROR "Build failed.")
endif()

if(BUILD_TESTS)
  if(WIN32)
    set(TEST_EXE_PATH "${BUILD_DIR}/tests/${PROJECT_NAME}_tests.exe")
  else()
    set(TEST_EXE_PATH "${BUILD_DIR}/tests/${PROJECT_NAME}_tests")
  endif()

  if(EXISTS ${TEST_EXE_PATH})
    execute_process(COMMAND ${TEST_EXE_PATH} RESULT_VARIABLE TEST_RESULT)
    if(NOT TEST_RESULT EQUAL 0)
      message(WARNING "Tests failed.")
    endif()
  else()
    message(WARNING "Test executable not found: ${TEST_EXE_PATH}")
  endif()
endif()

if(EXISTS ${EXE_PATH})
  message(STATUS "Running executable: ${EXE_PATH}")
  execute_process(COMMAND ${EXE_PATH} RESULT_VARIABLE RUN_RESULT)
  if(NOT RUN_RESULT EQUAL 0)
    message(WARNING "Executable exited with code: ${RUN_RESULT}")
  endif()
else()
  message(FATAL_ERROR "Executable not found: ${EXE_PATH}")
endif()

message(STATUS "Done.")
