include_directories(../libA)
add_executable(integration_test1 main.cpp)
target_link_libraries(integration_test1 libA)

add_test(NAME test1 COMMAND $<TARGET_FILE:integration_test1>)

