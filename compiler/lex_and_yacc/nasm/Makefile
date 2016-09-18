
CC = gcc
CFLAGS = -m32

AS = nasm
AFLAGS = -f elf

ALL = hello printf1 printf2 fltarith

%.o: %.asm
	$(AS) $(AFLAGS) $<

%: %.o
	$(CC) $(CFLAGS) $< -o $@

all: $(ALL)

clean:
	rm -f $(ALL) *.o
