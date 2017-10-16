#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "health.h"

/*
* health_util.c - Helper functions for the Health Monitoring System
*
* Add any optional helper function declarations here, define 
* the functions after the required functions below.
*
* static void myOptionalFunc();   // EXAMPLE 
*
*/

void buffer_insert();
int find_start();

/*
* addPatient: check-in a new patient
*   (1) allocate a new Chart for the patient
*   (2) initialize the chart with the passed patientID
*   (3) new patients are inserted at the start of the patient list
*
* (note that the variable patientList is globally accessible)
*/
void addPatient( int patientID ){
	Chartptr chart; //patient's chart
	if (getChart(patientID) != NULL) {
		return; //patient already exists, don't need to do anything
	}
	//initialize chart
	chart = malloc(sizeof(Chart));
	chart->id = patientID;
	chart->buffer = NULL;
	//add to front of patientList
	chart->next = patientList;
	patientList = chart;
}

/*
* addHealthType: add a new health type buffer for a given patient
*	(1) allocate a new CircularBuffer
*	(2) initialize the buffer
* 	(3) link it to the existing patient's Chart
*/
void addHealthType( int patientID, int newType ){
	Chartptr chart = getChart(patientID); //patient's chart
	if (chart == NULL) {
		return; //patient doesn't exist, can ignore request
	}
	//initialize buffer
	CBuffptr buff; //patient's buffer
	buff = malloc(sizeof(CircularBuffer));
	buff->type = newType;
	buff->start = 0;
	buff->end = 0;
	//add to patient's buffer
	buff->next = chart->buffer;
	chart->buffer = buff;
}

/*
*  getChart: given a patientID, return a pointer to their Chart
*/
Chartptr getChart( int patientID ){
	Chartptr foundChart = NULL; //will hold patient's chart if found

	//traverse through patientList until end or patient found
	Chartptr curr = patientList;
	while (curr != NULL) {
		if (curr->id == patientID) {
			foundChart = curr;
			break;
		}
		curr = curr->next;
	}
	return foundChart;
}

/*
*  getHealthType: given a patientID & healthType, return a pointer 
*  to the CircularBuffer for that type. If the health type does NOT exist 
*  for that patient, return NULL
*/
CBuffptr getHealthType( int patientID, int healthType ){
	CBuffptr foundType = NULL; //will hold type buffer if found
	Chartptr chart = getChart(patientID); //patient's chart
	if (chart == NULL) {
		return foundType; //patient doesn't exist, can ignore
	}
	//traverse through patient's buffer until healthType found
	CBuffptr curr = chart->buffer;
	while (curr != NULL) {
		if (curr->type == healthType) {
			foundType = curr;
			break;
		}
		curr = curr->next;
	}
	return foundType;
}

/*
*  addHealthReading: given a pointer to CircularBuffer, add the passed
*  timestamp and health data type reading to the buffer
*/
void addHealthReading( CBuffptr buffer, char* timestamp, int reading ){
	if (buffer == NULL) {
		return; //type not created, can ignore request
	}
	//create element
	Element e;
	strcpy(e.timestamp, timestamp);
	e.value = reading;
	//insert into circular buffer
	buffer_insert(buffer, e);
}

/*
*  removePatient: check-out an existing patient
*	  (1) delete the patient's Chart & accompanying 
*         health data readings.
*     (2) update the list of current patients
*/
void removePatient( int patientID ){
	Chartptr chart = NULL;
	if (patientList->id == patientID) {
		//head of patientList is target chart
		chart = patientList;
		patientList = patientList->next;
	} else {
		//traverse through patientList to find patient
		Chartptr last = patientList; //last patient - used to fix 'next' attribute when removing
		Chartptr curr = patientList; //current patient
		while (curr != NULL) {
			if (curr->id == patientID) {
				chart = curr;
				last->next = curr->next; //remove patient from list
				break;
			}
			last = curr;
			curr = curr->next;
		}
	}
	if (chart == NULL) {
		return; //patient doesn't exist, can ignore request
	}

	//free patient's buffers
	CBuffptr buff = chart->buffer;
	while (buff != NULL) {
		CBuffptr tmp = buff->next; //hold next buffer to advance to after freeing current
		free(buff);
		buff = tmp;
	}
	chart->buffer = NULL; //set to NULL so memory isn't accessed anymore
	free(chart);
}

void resetPatient(int id) {
	Chartptr chart = getChart(id);
	if (chart == NULL) {
		return; //patient doesn't exist, can ignore request
	}
	//iterate through type circularbuffers, free each
	CBuffptr buff = chart->buffer;
	while (buff != NULL) {
		CBuffptr tmp = buff->next; //hold next buffer to advance to after free
		free(buff);
		buff = tmp;
	}
	chart->buffer = NULL; //set to NULL so memory isn't accessed anymore
}

/*
* Optional helper functions defined starting here:
*
* static void myOptionalFunc(){ }  // EXAMPLE
*
*/

/*
* Insert elemetn 'reading' into 'buffer', overwriting oldest element in buffer if necessary
*/
void buffer_insert(CBuffptr buffer, Element reading) {
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
int find_start(CBuffptr buffer) {
        int end = buffer->end;
        if (buffer->start == 0) {
                return 0; //buffer hasn't looped around yet, index 0 is oldest
        } else {
                return (buffer->end) % MAXREADINGS; //buffer has looped around, current write index holds olde$
        }
}
