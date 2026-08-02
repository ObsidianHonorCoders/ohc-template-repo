cmake_minimum_required(VERSION 3.25)

project(ohc_template_repo VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

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
    add_subdirectory(tests)
endif()
