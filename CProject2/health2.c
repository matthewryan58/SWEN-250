/*
* Health Monitoring System
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define MAXPATIENTS 5
#define MAXREADINGS 10
#define MAXTYPES 5
#define MAXTIME 8

/* One health type reading: timestamp + actual value */
typedef struct{
	char timestamp[MAXTIME+1];
	int value;
}Element;

/* Circular buffer of health type readings */
typedef struct{
	int start;	/* index of oldest reading */
	int end;	/* index of most current reading */
	Element reading[MAXREADINGS];
}CircularBuffer;

/* Patient's health chart: ID + multiple health type readings */
typedef struct{
	int id;
	CircularBuffer buffer[MAXTYPES];
}Chart;

/*
* Health records for all patients defined here.
* The variable record is visible to all functions
* in this file, i.e. it is global.
*/
Chart record[MAXPATIENTS];

/*
* Insert elemetn 'reading' into 'buffer', overwriting oldest element in buffer if necessary
*/
void buffer_insert(CircularBuffer *buffer, Element reading) {
	buffer->reading[buffer->end] = reading;
	buffer->end = (buffer->end + 1) % MAXREADINGS; //increment index, loop to beginning if needed
	if (buffer->start == 0 && buffer-> end == 0) {
		//buffer looped around once, now need to keep track of oldest element
		buffer->start = 1;
	}
}

/*
* Find and return index of oldest element in 'buffer'
*/
int find_start(CircularBuffer *buffer) {
	int end = buffer->end;
	if (buffer->start == 0) {
		return 0; //buffer hasn't looped around yet, index 0 is oldest
	} else {
		return (buffer->end) % MAXREADINGS; //buffer has looped around, current write index holds oldest element
	}
}

/*
* Print readings from 'buffer'
*/
void print_readings(CircularBuffer *buffer, int type) {
        if (buffer->start == 0 && buffer-> end == 0) { //empty readings buffer
                printf("<none>\n");
        } else {
                int i;
                int start = find_start(buffer); //start from oldest reading
                for (i = start; i < start + MAXREADINGS; i++) {
                        if (buffer->reading[i % MAXREADINGS].timestamp[0] == '\0') {
                                break; //blank reading, no more initialized readings.
                        }
			if (type == 1) {
				//temperature reading must be converted to float
                        	printf("%s: %.1f\n", buffer->reading[i % MAXREADINGS].timestamp, buffer->reading[i % MAXREADINGS].value/10.0);
                	} else {
				//all other readings are int
				printf("%s: %d\n", buffer->reading[i % MAXREADINGS].timestamp, buffer->reading[i % MAXREADINGS].value);
			}
		}
        }
}

char divider[] = "--------------------------------------------------"; //divider for text output
/*
* Print patient `id`'s readings for each reading type
*/
void print_patient(int id) {
        printf("%s\nReadings for patient ID = %d are:\n", divider, id);
        printf("Temperature:\n");
        print_readings(&record[id - 1].buffer[0], 1);
        printf("Heart Rate:\n");
        print_readings(&record[id - 1].buffer[1], 2);
        printf("Systolic Pressure:\n");
        print_readings(&record[id - 1].buffer[2], 3);
        printf("Diastolic Pressure:\n");
        print_readings(&record[id - 1].buffer[3], 4);
        printf("Respiration Rate:\n");
        print_readings(&record[id - 1].buffer[4], 5);
        printf("%s\n", divider);
}

void main() {
	int i, j;

	/* initialize health data records for each patient */

	for( i=0; i < MAXPATIENTS; i++ ){
    		record[i].id = i + 1;
    		for( j=0; j < MAXTYPES; j++ ){
        		record[i].buffer[j].start = 0;
			record[i].buffer[j].end = 0;
    		}
	}
	printf("Welcome to the Health Monitoring System\n\n");

	/*
	*  YOUR CODE GOES HERE:
	*  (1) Read a csv line of health data from stdin
	*  (2) Parse csv line into appropriate fields
	*  (3) Store health data in patient record or print if requested
	*  (4) Continue (1)-(3) until EOF
	*/

	//variables read from input
	int id;
	char timestamp[MAXTIME + 1];
	int type;
	int value;
	//

	while (scanf("%d, %s %d, %d[^\n]", &id, timestamp, &type, &value) != EOF) { //read line of input until EOF
		//create reading
		Element e;
		timestamp[MAXTIME] = '\0'; //remove trailing comma captured by scanf
		strcpy(e.timestamp, timestamp);
		e.value = value;

		if (type == 6) {
			//print command issued, print then continue to next line
			print_patient(id);
			continue;
		}
		//store user input as reading 
		buffer_insert(&record[id - 1].buffer[type - 1], e);
	}

	printf("\nEnd of Input\n");
}
