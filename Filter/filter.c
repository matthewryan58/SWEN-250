/*
 * Implementation of functions that filter values in strings.
 *****
 * YOU MAY NOT USE ANY FUNCTIONS FROM <string.h> OTHER THAN
 * strcpy() and strlen()
 *****
 */

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "filter.h"

#define NUL ('\0')

/*
 * YOU MAY FIND THIS FUNCTION USEFUL.
 * Return true if and only if character <c> is in string <s>.
 */
static bool includes(char c, char *s) {
	while( *s && c != *s ) {
		s++ ;
	}
	return c == *s ;
}

/*
 * YOU MAY ALSO FIND THIS FUNCTION USEFUL.
 * Return true if and only if string <pre> is a prefix of string <s>.
 */
static bool prefix(char *s, char *pre) {
	while( *pre && *s == *pre ) {
		s++ ;
		pre++ ;
	}
	return *pre == NUL ;
}

/*
 * Copy <string> to <result> while removing all occurrences of <ch>.
 */
void filter_ch_index(char string[], char result[], char ch) {
	int string_i; //string index iterator
	int result_i = 0; //result index iterator
	//iterate over string
	for (string_i = 0; string_i < strlen(string); string_i++) {
		if (string[string_i] != ch) {
			result[result_i++] = string[string_i]; //only need to increment result iterator when 'ch' not encountered
		}
	}
	result[result_i] = '\0'; //append null terminator
}

/*
 * Return a pointer to a string that is a copy of <string> with
 * all occurrences of <ch> removed. The returned string must occupy
 * the least possible dynamically allocated space.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *filter_ch_ptr(char *string, char ch) {
	char *p_copy = malloc(strlen(string) + 1); //allocate space for filtered string, unknown final l ength so string length + 1 for EOF
	char *p = p_copy; //copy pointer, use this var for iteration
	while (*string != '\0') {
		if (*string != ch) {
			*p = *string;
			p++; //only need to increment pointer when ch not encountered
		}
		string++; //iterate to next char for checking
	}
	*p = '\0'; //append null terminator

	p = malloc(strlen(p_copy) + 1); //allocate space for filtered string
	strcpy(p, p_copy); //copy the now filtered string to new allocation
	free(p_copy); //free allocated space from initial filter allocation

	return p;
}

/*
 * Copy <string> to <result> while removing all occurrences of
 * any characters in <remove>.
 */
void filter_any_index(char string[], char result[], char remove[]) {
	int string_i; //string index iterator
	int result_i = 0; //result index iterator
	int remove_i; //remove index iterator
	//iterate over string
	for (string_i = 0; string_i < strlen(string); string_i++) {
		//iterate over remove, check if string[string_i] is in it
		for (remove_i = 0; remove_i < strlen(remove); remove_i++) {
			if (string[string_i] == remove[remove_i]) {
				break;
			}
		}
		if (remove_i == strlen(remove)) { //reached end of remove iteration without break, string[string_i] not in remove
			result[result_i++] = string[string_i]; //add char to result, increment result iterator
		}
	}
	result[result_i] = '\0'; //append null terminator
}

/*
 * Return a pointer to a copy of <string> after removing all
 * occurrrences of any characters in <remove>.
 * The returned string must occupy the least possible dynamically
 * allocated space.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *filter_any_ptr(char *string, char* remove) {
	char *p_copy = malloc(strlen(string) + 1); //allocate space for filtered string, unknown final l ength so string length + 1 for EOF
	char *p = p_copy; //copy pointer, use this var for iteration
	char *remove_t; //secondary remove pointer for iteration
        while (*string != '\0') {
		remove_t = remove; //initialize to beginning of remove
		//iterate through remove
		while (*remove_t != '\0') {
			if (*string == *remove_t) {
				break; //character found in remove, skip it
			}
			remove_t++;
		}
		if (*remove_t == '\0') { //reached end of remove without break
			*p = *string;
			p++;
		}
		string++;
        }
        *p = '\0'; //append null terminator

        p = malloc(strlen(p_copy) + 1); //allocate space to exactly fit filtered string, + 1 for EOF
        strcpy(p, p_copy); //copy now filtered string to new allocation
        free(p_copy); //free allocated space from initial filter allocation

        return p;
}

/*
 * Return a pointer to a copy of <string> after removing all
 * occurrrences of the substring <substr>.
 * The returned string must occupy the least possible dynamically
 * allocated space.
 *****
 * YOU MAY *NOT* USE ARRAY INDEXING.
 *****
 */
char *filter_substr(char *string, char* substr) {
        char *p_copy = malloc(strlen(string) + 1); //allocate space for filtered string, unknown final l ength so string length + 1 for EOF
        char *p = p_copy; //copy pointer, use this var for iteration

        while (*string != '\0') {
		if (prefix(string, substr)) { //check if substr is a prefix of current string from pointer
			string += strlen(substr); //substr found, increment string past it to skip
		} else {
			//substr not found
			*p = *string;
			p++;
			string++;
		}
        }
        *p = '\0'; //append null terminator

        p = malloc(strlen(p_copy) + 1); //allocate space to exactly fit filtered string
        strcpy(p, p_copy); //copy now filtered string to new allocation
        free(p_copy); //free allocated space from initial filter allocation

        return p;
}
