section .data
	text: db "Digite el nombre del Archivo ",0
	len: equ $-text
	writecode: db 'w',0
	dirString: db  '%s',0

section .bss

nombreArchivo resb 100


section .text
extern printf
extern scanf
extern fopen
global main

main:
	xor ecx,ecx
	xor ebx,ebx
	xor eax,eax
	xor edx,edx
	push text
	call printf
	add esp,4
	push nombreArchivo
	push dirString
	call scanf
	add esp,4

crearArchivo:
	push writecode
	push nombreArchivo
	call fopen
	add esp,8
	cmp eax,0
	jne salir



salir:
	mov eax,1
	mov ebx,0
	int  80h 
