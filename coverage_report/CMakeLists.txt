FIND_PROGRAM(LCOV_PATH lcov)
FIND_PROGRAM(GENHTML_PATH genhtml)


if (NOT GENHTML_PATH) 
    message(FATAL_ERROR "Coverage needs lcov! Currently it's not found in this system")
endif()

if (NOT GENHTML_PATH) 
    message(FATAL_ERROR "Coverage needs genhtml! Currently it's not found in this system")
endif()

set(FILTER_FILES '/usr/include/*' 'doctest.h')
set(HTML_REPORT_ARGUMENTS --no-function-coverage --highlight --legend --branch-coverage --demangle-cpp)

add_subdirectory(unit_test_coverage)
add_subdirectory(total_test_coverage)
add_subdirectory(intergration_test_coverage)



#add_custom_target(tests_coverage_report
#
#    COMMAND ${LCOV_PATH} --directory 
#        ${PROJECT_BINARY_DIR} --capture --initial --output-file "${PROJECT_BINARY_DIR}/code_base.info"
#
#    # Zero the coverage counters.
#    COMMAND ${CMAKE_COMMAND} -DPROJECT_BINARY_DIR="${PROJECT_BINARY_DIR}" -P "${PROJECT_SOURCE_DIR}/cmake/ZeroCoverageCounters.cmake" 
#
#    # Run unit testintegration tests.
#    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure -R 'unittest_*'
#
#    COMMAND ${LCOV_PATH} --directory 
#        ${PROJECT_BINARY_DIR} --capture --output-file "${PROJECT_BINARY_DIR}/unit_tests.info"
#
#    # Zero the coverage counters.
#    COMMAND ${CMAKE_COMMAND} -DPROJECT_BINARY_DIR="${PROJECT_BINARY_DIR}" -P "${PROJECT_SOURCE_DIR}/cmake/ZeroCoverageCounters.cmake" 
#
#    # Run integration tests.
#    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure -E 'unittest_*'
#
#    COMMAND ${LCOV_PATH} --directory 
#        ${PROJECT_BINARY_DIR} --capture --output-file "${PROJECT_BINARY_DIR}/integration_tests.info"
#
#    COMMAND ${LCOV_PATH} 
#        -a "${PROJECT_BINARY_DIR}/integration_tests.info"
#        -a "${PROJECT_BINARY_DIR}/unit_tests.info"
#        -a "${PROJECT_BINARY_DIR}/code_base.info"
#        -o "${PROJECT_BINARY_DIR}/coverage_unfiltered.info"
#    COMMAND  ${LCOV_PATH} 
#        --remove "${PROJECT_BINARY_DIR}/coverage_unfiltered.info" '/usr/include/*' 'doctest.h'
#        -o "${PROJECT_BINARY_DIR}/coverage.info"
#
#    COMMAND ${GENHTML_PATH} "${PROJECT_BINARY_DIR}/coverage.info"
#
#    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
#    COMMENT "Generating coveralls output..."
#)
