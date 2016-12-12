
macro(add_unit_test_target)
    cmake_parse_arguments(ARG "" "TARGET" "" ${ARGN})
    set(UNIT_TEST_TARGET ${ARG_TARGET})

    #Run unit test as part of build
    add_custom_command(TARGET ${UNIT_TEST_TARGET} POST_BUILD COMMAND $<TARGET_FILE:${UNIT_TEST_TARGET}>)
       
    set(tmp ${UNIT_TEST_TARGETS})
    list(APPEND tmp ${UNIT_TEST_TARGETS})
    set(UNIT_TEST_TARGETS ${tmp} CACHE INTERNAL "All unit test targets")
endmacro()
