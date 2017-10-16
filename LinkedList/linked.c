/*
linked - linked list functions
*/

#include <stdio.h>
#include <stdlib.h>
#include "linked.h"

static struct node* head = NULL;

#define NODE_SIZE (sizeof(struct node))

/************************************************************
 length - return length of a list
 ************************************************************/
int length(){
	//iterate over list until NULL reached, count each node
	int len = 0; //length
	struct node* n = head; //pointer to current node in iteration
	while (n != NULL) {
		len++;
		n = n->next;
	}
	return len;
}


/************************************************************
 push - add new node at beginning of list
 ************************************************************/
void push(int data) {
	//create node, set it's next to current head node, replace head variable
	struct node* n = malloc(NODE_SIZE); //node to add to list
	n->next = head;
	n->data = data;
	head = n;
}

/************************************************************
 pop - delete node at beginning of non-empty list and return its data
 ************************************************************/
int pop() {
	//get head node, set head variable to it's next
	struct node* n = head; //node to add to list
	head = head->next;
	int value = n->data; //retrieve value before free
	free(n);
	return value;
}

/************************************************************
 appendNode - add new node at end of list
 ************************************************************/
void appendNode(int data) {
	//iterate through list until NULL reached, insert new node at end
	struct node* n = malloc(NODE_SIZE); //node to add to list
	n->data = data;
	struct node* i = head; //pointer to current node in iteration
	if (i != NULL) {
		//iterate until NULL is reached
		while (i->next != NULL) {
			i = i->next;
		}
		//next node is NULL, replace with new node
		i->next = n;
	} else {
		//list is empty, new node will be the head
		head = n;
	}
}

/************************************************************
 copyList - return new copy of list
 ************************************************************/
struct node* copyList() {
	struct node* copy = NULL; //pointer to beginning of new list
	struct node* copy_i; //pointer for iterating through new list, adding nodes
	struct node* from_i = head; //pointer for iterating through list that is being copied

	struct node* last = NULL; //pointer to last accessed node in new list to be able to set it's 'next' attribute

	while (from_i != NULL) {
		copy_i = malloc(NODE_SIZE); //new node
		if (copy == NULL) {
			copy = copy_i; //no elements yet, this will be the head
		}
		copy_i->data = from_i->data;
		//add node to new list
		if (last != NULL) {
			last->next = copy_i;
		}
		last = copy_i;
		//iterate to next node
		from_i = from_i->next;
	}
	return copy;
}

/************************************************************
 freeList - release all memory you allocated for the linked list.
 NOTE -- add a unit test that calls this function and observes
 that you returned 1 for success on freeing all memory.
 The instructor will verify that you correctly freed all
 allocated memory.
 ************************************************************/
int freeList() {
	//iterate through list, saving next before freeing current
	struct node* curr = head; //pointer to current node in iteration
	struct node* next; //temporary pointer to next node, allows pointer to be kept after free
	while (curr != NULL) {
		next = curr->next;
		free(curr);
		curr = next;
	}
	head = NULL; //space no longer allocated, set to NULL
	return 1;
}

/*
Compare two LinkedLists
return 1 if they contain the same values (in order), 0 otherwise
*/
int compareList(struct node* a, struct node* b) {
	while (a != NULL && b != NULL) { //cannot access data field of null nodes
		if (a->data == b->data) { //ensure both nodes have equal values
			if (!((a->next == NULL && b->next != NULL) || (a->next != NULL && b->next == NULL))) { //ensure both node's next node are both initialized or null, not one and the other
				a = a->next;
				b = b->next;
				continue;
			}
		}
		return 0;
	}
	return 1;
}

struct node* get_head() {
	return head;
}
