cmake_minimum_required(VERSION 3.25)

project(ohc_template_repo VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(FetchContent)

if(NOT DEFINED EXE_NAME)
    set(EXE_NAME "ohc_template_app")
endif()

include(CTest)

add_executable(${EXE_NAME}
    main.cpp
    src/template_module.cpp
)

target_include_directories(${EXE_NAME}
    PRIVATE
        include
)

if(MSVC)
    target_compile_options(${EXE_NAME} PRIVATE /W4)
else()
    target_compile_options(${EXE_NAME} PRIVATE -Wall -Wextra -Wpedantic)
endif()

if(BUILD_TESTING)
    set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
    set(BUILD_GMOCK ON CACHE BOOL "" FORCE)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG v1.14.0
        GIT_SHALLOW TRUE
    )
    FetchContent_MakeAvailable(googletest)

    add_subdirectory(tests)
endif()
