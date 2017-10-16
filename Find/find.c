/*
 * Implementation of functions that find values in strings.
 *****
 * YOU MAY NOT USE ANY FUNCTIONS FROM <string.h>
 *****
 */

#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "find.h"

#define NOT_FOUND (-1)	// integer indicator for not found.

/*
 * Return the index of the first occurrence of <ch> in <string>,
 * or (-1) if the <ch> is not in <string>.
 */
int find_ch_index(char string[], char ch) {
	int i = 0; //iteration index holder
	//iterate over the string until ch is found
	for (i = 0; i < strlen(string); i++) {
		if (string[i] == ch) {
			return i; //character at index i matches ch
		}
	}
	return NOT_FOUND;
}

/*
 * Return a pointer to the first occurrence of <ch> in <string>,
 * or NULL if the <ch> is not in <string>.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *find_ch_ptr(char *string, char ch) {
	//increment pointer until matches ch or EOF
	while (*string != '\0' && *string != ch) {
		string++;
	}
	if (*string == ch) {
		return string; //character at pointer address matches ch
	} else {
		return NULL;
	}
}

/*
 * Return the index of the first occurrence of any character in <stop>
 * in the given <string>, or (-1) if the <string> contains no character
 * in <stop>.
 */
int find_any_index(char string[], char stop[]) {
	int i = 0; //'string' iteration index holder
	int j = 0; //'stop' iteration index holder
	//iterate over characters in 'string'
	for (i = 0; i < strlen(string); i++) {
		//iterate over characters in 'stop'
		for (j = 0; j < strlen(stop); j++) {
			if (string[i] == stop[j]) {
				return i; //character in 'string' matches character in 'stop'
			}
		}
	}
	return NOT_FOUND;
}

/*
 * Return a pointer to the first occurrence of any character in <stop>
 * in the given <string> or NULL if the <string> contains no characters
 * in <stop>.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *find_any_ptr(char *string, char* stop) {
	char *stop_t; //temporary 'stop' pointer incrementor

	while (*string != '\0') {
		stop_t = stop; //use stop pointer as base pointer
		//iterate through 'stop' for matching character
		while (*stop_t != '\0') {
			if (*string == *stop_t) {
				return string;
			}
			stop_t++;
		}
		string++;
	}
	return NULL;
}

/*
 * Return a pointer to the first character of the first occurrence of
 * <substr> in the given <string> or NULL if <substr> is not a substring
 * of <string>.
 * Note: An empty <substr> ("") matches *any* <string> at the <string>'s
 * start.
 *****
 * YOU MAY *NOT* USE INTEGERS OR ARRAY INDEXING.
 *****
 */
char *find_substr(char *string, char* substr) {
	char* string_t; //string temporary pointer incrementor
	char* substr_t; //substr temporary pointer incrementor

	//edge case, both string and substr empty
	if (*string == '\0' && *substr == '\0') {
		return string;
	}

	while (*string != '\0') {
		substr_t = substr; //use substr pointer as base for incrementor
		string_t = string; //use current string pointer as base for incrementor
		while (*substr_t != '\0') {
			if (*substr_t != *string_t) {
				break; //character mismatch
			}
			substr_t++;
			string_t++;
		}
		if (*substr_t == '\0') {
			return string; //end of substr was reached, must've matched string
		}
		string++;
	}
	return NULL;
}
