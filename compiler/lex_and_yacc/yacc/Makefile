CC = gcc
CFLGS = -std=c99
LEX = flex

all: calculator

clean:
	rm -f calculator calculator.tab.* calculator.c

calculator: calculator.c calculator.tab.c ex_shell.c
	$(CC) $(CFLGS) -o $@ $^ -lm


calculator.c: calculator.l
	$(LEX) -o $@ $<

calculator.tab.c: calculator.y
	bison -d calculator.y
