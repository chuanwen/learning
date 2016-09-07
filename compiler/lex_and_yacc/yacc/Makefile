CC = gcc
LEX = flex

all: calculator

clean:
	rm -f calculator *.c *.h

calculator: calculator.c calculator.tab.c
	$(CC) -o $@ calculator.c calculator.tab.c -lm

calculator.c: calculator.l
	$(LEX) -o $@ $<

calculator.tab.c: calculator.y
	bison -d calculator.y
