cmake_minimum_required(VERSION 3.25)

# Project configuration
project(
  ohc_template_repo
  VERSION 2.0.0
  LANGUAGES CXX
  DESCRIPTION "OHC C++ Project Template"
  HOMEPAGE_URL "https://github.com/ObsidianHonorCoders/ohc-template-repo")

# C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Export compile commands for clangd/IDE support
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Default executable name
if(NOT DEFINED EXE_NAME)
  set(EXE_NAME
      "ohc_template_app"
      CACHE STRING "Executable name" FORCE)
endif()

# Build testing option
option(BUILD_TESTING "Build unit tests" ON)
option(BUILD_DOCS "Build documentation with Doxygen" OFF)
option(ENABLE_SANITIZERS "Enable sanitizers (Address, Thread, UBSan)" OFF)
option(ENABLE_COVERAGE "Enable code coverage instrumentation" OFF)

# Policies for modern CMake
cmake_policy(SET CMP0077 NEW) # option() honors normal variables
cmake_policy(SET CMP0091 NEW) # FindPython3 prefers shared
cmake_policy(SET CMP0117 NEW) # target_link_libraries() with absolute paths

# Include CTest for testing support
include(CTest)

# Sanitizer support
if(ENABLE_SANITIZERS AND NOT MSVC)
  add_compile_options(-fsanitize=address,undefined -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address,undefined)
endif()

# Coverage support
if(ENABLE_COVERAGE AND NOT MSVC)
  add_compile_options(--coverage -fprofile-arcs -ftest-coverage)
  add_link_options(--coverage)
endif()

# Compiler warnings
if(MSVC)
  add_compile_options(/W4 /WX)
else()
  add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

# Include FetchContent for dependencies
include(FetchContent)

# ---- Main Library Target ----
add_library(template_module STATIC src/template_module.cpp)

target_include_directories(
  template_module PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                         $<INSTALL_INTERFACE:include>)

target_compile_features(template_module PUBLIC cxx_std_17)

set_target_properties(
  template_module
  PROPERTIES POSITION_INDEPENDENT_CODE ON
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN ON)

# ---- Main Executable ----
add_executable(${EXE_NAME} main.cpp)

target_link_libraries(${EXE_NAME} PRIVATE template_module)

# ---- Testing ----
if(BUILD_TESTING)
  # GoogleTest via FetchContent
  set(INSTALL_GTEST
      OFF
      CACHE BOOL "" FORCE)
  set(BUILD_GMOCK
      ON
      CACHE BOOL "" FORCE)
  set(gtest_force_shared_crt
      ON
      CACHE BOOL "" FORCE)

  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.14.0
    GIT_SHALLOW TRUE)
  FetchContent_MakeAvailable(googletest)

  add_subdirectory(tests)
endif()

# ---- Documentation ----
if(BUILD_DOCS)
  find_package(Doxygen QUIET)
  if(DOXYGEN_FOUND)
    set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
    set(DOXYGEN_HTML_OUTPUT "html")
    set(DOXYGEN_PROJECT_LOGO_PATH
        "${CMAKE_CURRENT_SOURCE_DIR}/docs/DoxyPage/OHC-logo-lowresolution.png")
    set(DOXYGEN_PROJECT_ICON_PATH
        "${CMAKE_CURRENT_SOURCE_DIR}/docs/DoxyPage/OHC-logo-lowresolution.png")
    set(DOXYGEN_HTML_EXTRA_STYLESHEET
        "${CMAKE_CURRENT_SOURCE_DIR}/docs/DoxyPage/custom.css")

    message(STATUS "Doxygen source dir: ${CMAKE_CURRENT_SOURCE_DIR}")
    message(STATUS "Doxygen output dir: ${DOXYGEN_OUTPUT_DIRECTORY}")
    message(STATUS "Doxygen HTML output dir: ${DOXYGEN_HTML_OUTPUT}")
    message(STATUS "Doxygen extra stylesheet: ${DOXYGEN_HTML_EXTRA_STYLESHEET}")

    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile
                   ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)

    doxygen_add_docs(
      docs ALL ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      COMMENT "Generating API documentation with Doxygen")
  else()
    message(WARNING "Doxygen not found, documentation target disabled")
  endif()
endif()

# ---- Installation ----
include(GNUInstallDirs)

# Install library
install(
  TARGETS template_module
  EXPORT ${PROJECT_NAME}-targets
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  INCLUDES
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Install headers
install(
  DIRECTORY include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING
  PATTERN "*.hpp")

# Install executable
install(TARGETS ${EXE_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# Export targets for downstream consumers
install(
  EXPORT ${PROJECT_NAME}-targets
  FILE ${PROJECT_NAME}-targets.cmake
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# Generate config package
include(CMakePackageConfigHelpers)
configure_package_config_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# ---- CPack for packaging ----
include(CPack)
