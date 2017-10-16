#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "health.h"

/*
* Main function for the Health Monitoring System. Primarily responsible for
* processing input of csv lines and printing as required. Data structures are
* maintained using the helper functions in health_util.c
* 
*/

Chartptr patientList = NULL;    /* Define global variable patientList (declared in health.h) */

/*
* Print readings from 'buffer'
*/
void print_readings(CBuffptr buffer, int type) {
        if (buffer == NULL || (buffer->start == 0 && buffer-> end == 0)) { //empty readings buffer
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
                                printf("%s: %.1f\n", buffer->reading[i % MAXREADINGS].timestamp, buffer->reading[i % MAXREADINGS].value / 10.0);
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
	if (getChart(id) == NULL) {
		return;
	}
        printf("%s\nReadings for patient ID = %d are:\n", divider, id);
        printf("Temperature:\n");
	print_readings(getHealthType(id, 1), 1);
        printf("Heart Rate:\n");
	print_readings(getHealthType(id, 2), 2);
        printf("Systolic Pressure:\n");
        print_readings(getHealthType(id, 3), 3);
        printf("Diastolic Pressure:\n");
        print_readings(getHealthType(id, 4), 4);
        printf("Respiration Rate:\n");
        print_readings(getHealthType(id, 5), 5);
        printf("%s\n", divider);
}

void main(){
	printf("Welcome to the Health Monitoring System\n\n");

	//variables read from input
        int id;
        char timestamp[MAXTIME + 1];
        int type;
        int value;

        while (scanf("%d, %s %d, %d[^\n]", &id, timestamp, &type, &value) != EOF) { //read line of input until EOF
		timestamp[MAXTIME] = '\0'; //remove trailing comma
		if (type >= 6 || type == 0) { //commands, not readings
			switch (type) {
			case 6:
				print_patient(id);
				break;
			case 7:
				printf("%s\n%s: Patient ID = %d checking in\n%s\n", divider, timestamp, id, divider);
				addPatient(id);
				break;
			case 8:
				printf("%s\n%s: Patient ID = %d checking out\n%s\n", divider, timestamp, id, divider);
				removePatient(id);
				break;
			case 9:
				addHealthType(id, value);
				break;
			case 0:
				printf("%s\n%s: Patient ID = %d reset data\n%s\n", divider, timestamp, id, divider);
				resetPatient(id);
				break;
			}
		} else { //reading
			CBuffptr buffer = getHealthType(id, type);
			if (buffer != NULL) { //only continue if type buffer exists for specified patient
				addHealthReading(buffer, timestamp, value);
        		}
		}
	}

	printf("\nEnd of Input\n");

}
