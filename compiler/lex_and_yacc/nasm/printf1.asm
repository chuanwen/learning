; Equivalent C code
; /* printf1.c  print an int and an expression */
; #include 
; int main()
; {
;   int a=5;
;   printf("a=%d, eax=%d\n", a, a+2);
;   return 0;
; }

        extern printf               ; the C function, to be called

        SECTION .data               ; Data section, initialized variables
a:      dd 5                        ; int a = 5;
fmt:    db "a=%d, eax=%d", 10, 0    ; The printf format, ends with '\0'

        SECTION .text               ; Code section
        global main
main:
        push ebp                    ; set up stack frame
        mov ebp, esp

        mov eax, [a]                ; put variable a from memory to register
        add eax, 2                  ; a+2
        push eax                    ; arg 3, value of a+2
        push dword [a]              ; arg 2, value of a
        push dword fmt              ; arg 1, pointer to format string
        call printf                 ; call C function
        add esp, 12                 ; pop stack 3 times (4 bytes each)

        mov esp, ebp                ; takedown stack frame
        pop ebp                     ; same as "leave"  op

        mov eax, 0                  ; 0 = normal return
        ret