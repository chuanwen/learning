#include <stdio.h>
#include <math.h>

double add(double x) {
    return x + 1.56;
}

double mul(double x) {
    return x * 2.73;
}

double combine(double x) {
    double y = add(x);
    y = cos(y);
    return mul(y);
}

int main() {
    double x;
    scanf("%f", &x);
    printf("%f\n", combine(x));
    return 0;
}
