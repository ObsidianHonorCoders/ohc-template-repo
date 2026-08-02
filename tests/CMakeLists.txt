add_executable(test_${EXE_NAME}
    test_template_module.cpp
    ${CMAKE_SOURCE_DIR}/src/template_module.cpp
)

target_include_directories(test_${EXE_NAME}
    PRIVATE
        ${CMAKE_SOURCE_DIR}/include
)

if(MSVC)
    target_compile_options(test_${EXE_NAME} PRIVATE /W4)
else()
    target_compile_options(test_${EXE_NAME} PRIVATE -Wall -Wextra -Wpedantic)
endif()

target_link_libraries(test_${EXE_NAME}
    PRIVATE
        GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(test_${EXE_NAME})
