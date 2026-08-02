add_executable(test_${EXE_NAME}
    test_main.cpp
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

add_test(NAME template_unit_tests COMMAND test_${EXE_NAME})
