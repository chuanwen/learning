CC = gcc

ALL = echo identifier wc
all: $(ALL)

clean:
	rm -f $(ALL) *.c

.l.c:
	flex -o $@ $<

echo: echo.c
	$(CC) $< -o $@

identifier: identifier.c
	$(CC) $< -o $@

wc: wc.c
	$(CC) $< -o $@

