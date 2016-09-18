; A similar "C" program
; #include 
; int main()
; {
;   char   char1='a';         /* sample character */
;   char   str1[]="string";   /* sample string */
;   int    int1=1234567;      /* sample integer */
;   int    hex1=0x6789ABCD;   /* sample hexadecimal */
;   float  flt1=5.327e-30;    /* sample float */
;   double flt2=-123.4e300;   /* sample double */
; 
;   printf("Hello world: %c %s %d %X %e %E \n", /* format string for printf */
;          char1, str1, int1, hex1, flt1, flt2);
;   return 0;
; }

        extern printf               ; the C function, to be called

        SECTION .data               ; Data section, initialized variables
fmt:    db "Hello world: %c %s %d %X %e %E", 10, 0    ; The printf format, ends with '\0'
char1:  db 'a'
str1:   db "string",0
len:    equ $-str1
inta1:  dd 1234567
hex1:   dd 0x6789abcd
flt1:   dd 5.327e-30                ; 32-bit floating point
flt2:   dq -123.456789e300          ; 64-bit floating point

        SECTION .bss
flttmp: resq 1                      ; 64-bit temporary for printing flt1

        SECTION .text               ; Code section
        global main
main:
        push ebp                    ; set up stack frame
        mov ebp, esp

        fld dword [flt1]            ; need to convert 32bit to 64bit
        fstp qword [flttmp]

        push dword [flt2+4]         ; 64-bit float (bottom)
        push dword [flt2]           ; 64-bit float (top)
        push dword [flttmp+4]
        push dword [flttmp]
        push dword [hex1]
        push dword [inta1]
        push dword str1
        push dword [char1]
        push dword fmt
        call printf
        add esp, 36                ; pop stack 9 times (4 bytes each)

        mov esp, ebp                ; takedown stack frame
        pop ebp                     ; same as "leave"  op

        mov eax, 0                  ; 0 = normal return
        ret