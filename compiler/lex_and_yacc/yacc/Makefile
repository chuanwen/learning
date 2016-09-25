CC = gcc
CFLGS = -std=c99 -g
LEX = flex

all: calc calcc

clean:
	rm -f calc calcc calculator.tab.* calculator.c *.o p?.asm p1 p2

calc: calculator.c calculator.tab.c ex_common.c ex_shell.c
	$(CC) $(CFLGS) -o $@ $^ -lm

calcc: calculator.c calculator.tab.c ex_common.c ex_compiler.c
	$(CC) $(CFLGS) -o $@ $^ -lm

calculator.c: calculator.l
	$(LEX) -o $@ $<

calculator.tab.c: calculator.y
	bison -d calculator.y

test: calcc
	./calcc p1.ca
	./program_test.sh p1 p1.expected "basic math test"
	./calcc p2.ca
	./program_test.sh p2 p2.expected "basic number comparison <= <, >, >=, !=, =="
run: calc calcc
	./calcc p0.ca && ./p0
	./calcc p1.ca && ./p1