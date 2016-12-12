macro(turn_on_coverage_report)

    if(NOT (CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX) AND (NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "Clang"))
        message(FATAL_ERROR "Coverage needs GCC compiler. The current compiler ${CMAKE_C_COMPILER_ID} is not GNU gcc!")
    endif()

    if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
        message(FATAL_ERROR "Coverage: Code coverage results with an optimised (non-Debug) build may be misleading! Add -DCMAKE_BUILD_TYPE=Debug")
    endif()

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
endmacro()
