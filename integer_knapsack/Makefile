CC=gcc
CFLAGS=-c -Wall -std=c99

all: knapsack

knapsack: maintest.o integer_knapsack.o 
	$(CC) maintest.o integer_knapsack.o -o knapsack
	rm -rf *o

maintest.o: maintest.c
	$(CC) $(CFLAGS) maintest.c

integer_knapsack.o: integer_knapsack.c
	$(CC) $(CFLAGS) integer_knapsack.c

clean:
	rm -rf *o knapsack
