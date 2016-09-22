CC = gcc
CFLGS = -std=c99 -g
LEX = flex

all: calc calcc

clean:
	rm -f calc calcc calculator.tab.* calculator.c *.o p*.asm p0 p1

calc: calculator.c calculator.tab.c ex_shell.c
	$(CC) $(CFLGS) -o $@ $^ -lm

calcc: calculator.c calculator.tab.c ex_compiler.c
	$(CC) $(CFLGS) -o $@ $^

calculator.c: calculator.l
	$(LEX) -o $@ $<

calculator.tab.c: calculator.y
	bison -d calculator.y

run: calc calcc
	./calcc p0.ca && ./p0
	./calcc p1.ca && ./p1