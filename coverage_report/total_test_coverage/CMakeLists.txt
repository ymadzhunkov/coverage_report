set(CODE_BASE_INFO   "${PROJECT_BINARY_DIR}/coverage_report/code_base.info")
set(TEST_INFO        "${PROJECT_BINARY_DIR}/coverage_report/total_tests.info")
set(UNFILTERED_INFO  "${PROJECT_BINARY_DIR}/coverage_report/coverage_unfiltered.info")
set(FILTERED_INFO    "${PROJECT_BINARY_DIR}/coverage_report/total_test_suite") 
set(LOG ${PROJECT_BINARY_DIR}/coverage_report/log.txt)
set(HTML_REPORT_ARGUMENTS --no-function-coverage --highlight --legend --branch-coverage --demangle-cpp)
add_custom_target(total_test_coverage_report
    # Collect code base from the entire project
    COMMAND ${LCOV_PATH} --directory ${PROJECT_BINARY_DIR} --capture --initial -o ${CODE_BASE_INFO} > ${LOG} 2>&1
    # Zero the coverage counters.
    COMMAND ${CMAKE_COMMAND} -DPROJECT_BINARY_DIR="${PROJECT_BINARY_DIR}" -P "${PROJECT_SOURCE_DIR}/cmake/ZeroCoverageCounters.cmake" > ${LOG} 2>&1
    # Run unit and integration tests.
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure -E 'unittest_*' > ${LOG} 2>&1
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure -R 'unittest_*' > ${LOG} 2>&1
    # Collect coverage data from last run
    COMMAND ${LCOV_PATH} --directory ${PROJECT_BINARY_DIR} --capture --output-file ${TEST_INFO} > ${LOG} 2>&1
    # Combine last coverage run with code base
    COMMAND ${LCOV_PATH} -a ${TEST_INFO} -a ${CODE_BASE_INFO} -o ${UNFILTERED_INFO}> ${LOG} 2>&1
    # Filter 'usr/include' and other similar files
    COMMAND  ${LCOV_PATH} --remove ${UNFILTERED_INFO} ${FILTER_FILES} -o ${FILTERED_INFO}> ${LOG} 2>&1
    # Generate html report 
    COMMAND ${GENHTML_PATH} ${FILTERED_INFO} ${HTML_REPORT_ARGUMENTS} --output-directory ${PROJECT_BINARY_DIR}/coverage_report> ${LOG} 2>&1
    # Working directory on top of binary dir, so we can discover all tests
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT "Generating coverage report for unit and integration tests -> ${PROJECT_BINARY_DIR}/coverage_report/index.html"
)
