
macro(add_unit_test_target)
    cmake_parse_arguments(ARG "" "TARGET" "" ${ARGN})
    set(UNIT_TEST_TARGET ${ARG_TARGET})

    #Run unit test as part of build
    add_custom_command(TARGET ${UNIT_TEST_TARGET} POST_BUILD COMMAND $<TARGET_FILE:${UNIT_TEST_TARGET}>)

    #Register unit test in ctests
    add_test(NAME unittest_${UNIT_TEST_TARGET} COMMAND $<TARGET_FILE:${UNIT_TEST_TARGET}>)
endmacro()
