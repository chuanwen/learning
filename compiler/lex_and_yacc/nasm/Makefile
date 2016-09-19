
CC = gcc
CFLAGS = -m32

AS = nasm
AFLAGS = -f elf

ALL = hello printf1 printf2 fltarith test.asm

%.o: %.asm
	$(AS) $(AFLAGS) $<

%: %.o
	$(CC) $(CFLAGS) $< -o $@

all: $(ALL)

clean:
	rm -f $(ALL) *.o

test.asm: test.c
	$(CC) $(CFLAGS) -c -fno-asynchronous-unwind-tables -O1 $<
	objconv -fnasm test.o
