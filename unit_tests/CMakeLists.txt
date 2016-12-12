include_directories(../doctest)
include_directories(../libA)
add_executable(test_factorial test_factorial.cpp)
target_link_libraries(test_factorial libA)
