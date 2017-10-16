#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define FALSE (0)
#define TRUE  (1)

#define BUFSIZE (512) //read buffer size

/*
Read line from stdin
returns 1 if EOF read, else 0
*/
int readLine(char buf[]) {
	int i = 0; //track index in buf
	int ch = getchar(); //read char from stdin
	while (ch != '\n' && ch != EOF) { //terminate reading if newline of EOF read
		if (i < BUFSIZE) { //ensure buffer overflow does not occur
			buf[i++] = ch; //store char
			ch = getchar(); //read next char
		} else {
			break;
		}
	}
	if (ch == '\n') {
		buf[i++] = '\n';
	}
	buf[i] = '\0'; //append nullbyte
	if (ch == EOF) {
		return 1; //cannot continue reading
	} else {
		return 0; //can continue reading
	}
}

/*
Count words in line (anything separated by spaces = word)
*/
int countWords(char line[]) {
	int count = 0; //number of words
	int lastSpace = TRUE; //keep track of if last char was space
	int lineSize = strlen(line); //store line size for efficiency
	int i;

	//iterate over chars in line
	for (i = 0; i < lineSize; i++) {
		if (line[i] == '\n') {
			break;
		} else if (line[i] ==  ' ') {
			if (lastSpace == FALSE) { //word was terminated with space
				count++;
			}
			lastSpace = TRUE; //current char is a  space
		} else {
			lastSpace = FALSE; //current char is not a space
		}
	}
	//check for word at end of line
	if (lastSpace == FALSE) { //last character read was not space
		count++;
	}
	return count;
}

int main() {
	int tot_chars = 0; //total characters
	int tot_lines = 0; //total lines
	int tot_words = 0; //total words

	int status = 0; //track if last line read contained EOF
	char buf[BUFSIZE + 1] = "placeholder"; //buffer to store line reads
	while (status == 0) {
		status = readLine(buf);
		if (status != 0) {
			break;
		}
		tot_chars += strlen(buf);
		tot_lines++;
		tot_words += countWords(buf);
	}

	printf("%d %d %d\n", tot_lines, tot_words, tot_chars);
	return 0;
}
