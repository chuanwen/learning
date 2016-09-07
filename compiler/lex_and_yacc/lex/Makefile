CC = gcc
LEX = flex

ALL = echo identifier wc
all: $(ALL)

clean:
	rm -f $(ALL) *.c

.l.c:
	$(LEX) -o $@ $<

echo: echo.c
	$(CC) $< -o $@

identifier: identifier.c
	$(CC) $< -o $@

wc: wc.c
	$(CC) $< -o $@

