		SECTION .data
msg:	db "Hello World!", 10		; 10 = cr
len:	equ $-msg					; "$" means here
									; len is a value, not an address


		SECTION .text				; code section
		global main					; make label available to linker
main:								; standard gcc entry point

		mov edx, len				; arg3, length of string to print
		mov ecx, msg				; arg2, pointer to string
		mov ebx, 1					; arg1, where to write, screen
		mov eax, 4					; sys_write
		int 0x80					; call into kernel

		mov ebx, 0					; exit code, 0 = normal
		mov eax, 1					; sys_exit 
		int 0x80					; call into kernel		
