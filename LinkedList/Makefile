# Makefile for linked list 

test: linked.o main.o unit_tests.o
	gcc -g -o test linked.o main.o unit_tests.o

unit_tests.o: unit_tests.h unit_tests.c linked.h
	gcc -g -c unit_tests.c

linked.o: linked.h linked.c
	gcc -g -c linked.c

main.o: linked.h main.c unit_tests.h
	gcc -g -c main.c

clean:
	rm *.o linked