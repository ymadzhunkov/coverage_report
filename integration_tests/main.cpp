#include "settings.h"
#include <cstdio>
int main() {
    Settings settings(123, 122);
    printf("Current settings\n    port1 = %d, port2 = %d\n", settings.port1, settings.port2);
    return 0;
}
