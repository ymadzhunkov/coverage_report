cmake_minimum_required(VERSION 2.8)
project(myproject)
enable_testing() 
# Add project cmake modules to path.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake)

# Option to generate Coverage report for given build.
option(REPORT_COVERAGE "Generate coverage report" ON)

if (REPORT_COVERAGE)
    include(CoverageReport)
    turn_on_coverage_report()
endif()

add_subdirectory(libA)
include(AddUnitTest)
add_subdirectory(unit_tests)
add_subdirectory(integration_tests)

FIND_PROGRAM(LCOV_PATH lcov)
FIND_PROGRAM(GENHTML_PATH genhtml)

add_custom_target(coverage_generate

    COMMAND ${LCOV_PATH} --directory 
        ${PROJECT_BINARY_DIR} --capture --initial --output-file "${PROJECT_BINARY_DIR}/code_base.info"

    # Zero the coverage counters.
    COMMAND ${CMAKE_COMMAND} -DPROJECT_BINARY_DIR="${PROJECT_BINARY_DIR}" -P "${PROJECT_SOURCE_DIR}/cmake/ZeroCoverageCounters.cmake" 

    COMMAND $<TARGET_FILE:test_factorial>

    COMMAND ${LCOV_PATH} --directory 
        ${PROJECT_BINARY_DIR} --capture --output-file "${PROJECT_BINARY_DIR}/unit_tests.info"

    # Zero the coverage counters.
    COMMAND ${CMAKE_COMMAND} -DPROJECT_BINARY_DIR="${PROJECT_BINARY_DIR}" -P "${PROJECT_SOURCE_DIR}/cmake/ZeroCoverageCounters.cmake" 

    # Run integration tests.
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure

    COMMAND ${LCOV_PATH} --directory 
        ${PROJECT_BINARY_DIR} --capture --output-file "${PROJECT_BINARY_DIR}/integration_tests.info"

    COMMAND ${LCOV_PATH} 
        -a "${PROJECT_BINARY_DIR}/integration_tests.info"
        -a "${PROJECT_BINARY_DIR}/unit_tests.info"
        -a "${PROJECT_BINARY_DIR}/code_base.info"
        -o "${PROJECT_BINARY_DIR}/coverage_unfiltered.info"
    COMMAND  ${LCOV_PATH} 
        --remove "${PROJECT_BINARY_DIR}/coverage_unfiltered.info" '/usr/include/*' 'doctest.h'
        -o "${PROJECT_BINARY_DIR}/coverage.info"

    COMMAND ${GENHTML_PATH} "${PROJECT_BINARY_DIR}/coverage.info"

    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT "Generating coveralls output..."
)
