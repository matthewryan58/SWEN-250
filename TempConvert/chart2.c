#include <stdio.h>

int main() {
    int f; //farenheit icrementer
    double c; //temp store celcius conversion
    printf("Fahrenheit-Celsius\n"); //output header
    for (f = 0; f <= 300; f += 20) {
        c = 5.0/9.0 * (f-32); //convert farenheit to celcius
        printf("%d\t%.1f\n", f, c); //output temperatures
    }
    return 0;
}
