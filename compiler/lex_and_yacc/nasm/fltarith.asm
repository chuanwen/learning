; A similar "C" program:
;  #include 
;  int main()
;  { 
;    double a=3.0, b=4.0, c;
;
;    c=5.0;
;    printf("%s, a=%.4f, b=%.4f, c=%.4f\n","c=5.0", a, b, c);
;    c=a+b;
;    printf("%s, a=%.4f, b=%.4f, c=%.4f\n","c=a+b", a, b, c);
;    c=a-b;
;    printf("%s, a=%.4f, b=%.4f, c=%.4f\n","c=a-b", a, b, c);
;    c=a*b;
;    printf("%s, a=%.4f, b=%.4f, c=%.4f\n","c=a*b", a, b, c);
;    c=c/a;
;    printf("%s, a=%.4f, b=%.4f, c=%.4f\n","c=c/a", a, b, c);
;    return 0;
; }
; flt reference doc: https://cs.fit.edu/~mmahoney/cse3101/float.html

        extern printf

%macro  print_abc 1                             ; macro with 1 parameter
        section .data
.str    db %1,0                                 ; %1 is the first parameter
        section .text

        push dword [c+4]
        push dword [c]
        push dword [b+4]
        push dword [b]
        push dword [a+4]
        push dword [a]
        push dword .str
        push dword fmt
        call printf
        add esp, 32
%endmacro

        section .data
a:      dq 3.333                                ; double
b:      dq 4.444
c:      dq 0.0
five:   dq 5.0                                  ; constant 5.0
fmt:    db "%s, a=%.4f, b=%.4f, c=%.4f", 10, 0        ; printf fmt string

        section .text
        global main
main:

lit5:
        fld qword [five]                        ; load 5.0
        fstp qword [c]                          ; pop flt pt stack to c
        print_abc "c=5.0"

add:
        fld qword [a]                           ; load double a (pushed on flt pt stack, st0)
        fadd qword [b]                          ; floating add b to st0
        fstp qword [c]
        print_abc "c=a+b"

sub:
        fld qword [a]
        fsub qword [b]
        fstp qword [c]
        print_abc "c=a-b"

mul:
        fld qword [a]
        fmul qword [b]
        fstp qword [c]
        print_abc "c=a*b"

div:
        fld qword [a]
        fdiv qword [b]
        fstp qword [c]
        print_abc "c=a/b"

        mov eax, 0
        ret