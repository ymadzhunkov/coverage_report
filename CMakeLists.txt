cmake_minimum_required(VERSION 2.8)
project(myproject)

# Add project cmake modules to path.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake)

# Option to generate Coverage report for given build.
option(REPORT_COVERAGE "Generate coverage report" ON)

if (REPORT_COVERAGE)
    include(CoverageReport)
    turn_on_coverage_report()
endif()

add_subdirectory(libA)
add_subdirectory(unit_tests)
