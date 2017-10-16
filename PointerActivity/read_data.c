/*
 * Implementation of the read_data module.
 *
 * See read_data.h for a description of the read_data function's
 * specification.
 *
 * Note that the parameter declarations in this module must be
 * compatible with those in the read_data.h header file.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "read_data.h"

#define BUF_SIZE 25
// Reads the three fields from lines such as W$1349$1.414$ into
// local variables using getchar().
// Converts the two numeric fields to numbers using atoi for the
// integer fields and atof for the double.
// Using a correctly defined set of parameters (use pointers) pass
// those values back to the program that called this function.
void read_data(char *arg1, int *arg2, double *arg3) {
	char c; //store character
	char i[BUF_SIZE + 1]; //store integer
	int iValue;
	char d[BUF_SIZE + 1]; //store decimal
	double dValue;
	int j; //iterator for reading integer and decimal

	//read character
	char tmp = getchar();
	while (tmp != '$') {
		c = tmp;
		tmp = getchar();
	}

	//read integer
        j = 0;
	tmp = getchar();
	while (tmp != '$') {
		i[j++] = tmp;
		tmp = getchar();
	}
	i[j] = '\0';
	iValue = atoi(i);

	//read decimal
	j = 0;
	tmp = getchar();
	while (tmp != '$') {
		d[j++] = tmp;
		tmp = getchar();
	}
	d[j] = '\0';
	dValue = atof(d);

	//give values to argument pointers
	*arg1 = c;
	*arg2 = iValue;
	*arg3 = dValue;

	return;
}
