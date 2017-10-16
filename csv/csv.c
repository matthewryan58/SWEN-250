/*
 * Skeleton implementation for the activity to parse and print
 * CSV formatted files read from standard input.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "csv.h"
#include "unit_tests.h"


/*
 * Returns true iff the character 'ch' ends a field. That is, ch is end of file,
 * a comma, or a newline.
 */

bool is_end_of_field(int ch) {
	return (ch == ',') || (ch == '\n') || (ch == EOF) ;
}

/*
 * Return the minimum of two integers.
 */

int min(int x, int y) {
	return x < y ? x : y ;
}

/*
 * Read the next field from standard input. Returns the value of getchar() that
 * stopped (terminated) the field.
 */

int get_field(f_string field) {
	char c; //temp character storage
	int i;
	for (i = 0; i < MAX_CHARS; i++) {
		c = getchar();
		if (is_end_of_field(c)) {
			break;
		}
		field[i] = c;
	}
	field[i] = '\0'; //terminate string
	return c;
}

/*
 * Read in a CSV line. No error checking is done on the number of fields or
 * the size of any one field.
 * On return, the fields have been filled in (and properly NUL-terminated), and
 * nfields is the count of the number of valid fields.
 * nfields == 0 means end of file was encountered.
 */

csv_line get_line() {
	csv_line line;
	line.nfields = 0;
	int i;
	for (i = 0; i < MAX_FIELDS; i++) {
		f_string f;
		int term = get_field(f);
		//check for end of file
		if (strlen(f) == 0 && term == EOF) {
			line.nfields = 0;
			break;
		}
		line.nfields++;
		strcpy(line.field[i], f);
		if (term != ',') {
			break; //end of line
		}
	}
	return line;
}

/*
 * Print a CSV line, associating the header fields with the
 * data line fields.
 * The minimum of the number of fields in the header and the data
 * determines how many fields are printed.
 */

void print_csv(csv_line header, csv_line data) {
	int fields = min(header.nfields, data.nfields);
	int i;
	for (i = 0; i < fields; i++) {
		printf("%s = %s\n", header.field[i], data.field[i]);
	}
}

/*
 * Driver - read a CSV line for the header then read and print data lines
 * until end of file.
 */

int main( int argc, char *argv[] ) {
	csv_line header ;
	csv_line current ;

	// LLK additional if statement to execute unit tests if program
	// name contains "test".
	if ( strstr( argv[0], "test" ) )
		return test() ;

	header = get_line() ;
	current = get_line() ;

	while ( current.nfields > 0 ) {
		print_csv(header, current) ;
		current = get_line() ;
	}

	return 0 ;
}
