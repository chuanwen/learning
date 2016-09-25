#include <stdio.h>

double double_abs(double x) {
    if (x > 0.0) {
        return x;
    }
    return -x;
}

void print_num(double x) {
    if (double_abs(x - (int)x) <= 1e-16) {
        printf("%d\n", (int)x);
    } else {
        printf("%g\n", x);
    }
}

double double_module(double x, double y) {
    return (int) x % (int) y;
}