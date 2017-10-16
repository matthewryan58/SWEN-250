/* linked.h - linked defines */

struct node {
	int data;
  	struct node* next;
};

/*
 * External declarations for linked functions.
 * 
*/

extern int length();
extern void push(int data);
extern int pop();
extern void appendNode(int data); 
extern struct node* copyList(); 
extern void printList();


