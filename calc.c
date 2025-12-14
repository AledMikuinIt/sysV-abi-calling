#include <stdio.h>

long calc(long a, long b, long c, long d, long e, long f, long g) {

    return (a + b*2) - (c + d*3) + (e*4 - f) + g;

}


int main() {

    long r = calc(5, 52, 86, 41, 3, 8, 6);

    printf("%ld", r);

    return 0;
}
