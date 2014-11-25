section .data
	text: db "Digite el nombre del Archivo ",0
	len: equ $-text
	writecode: db 'w',0
	dirString: db  '%s',0
	msg: db "ACTG",0
	lenm: equ $-msg 
	entrada: db "Digite el largo del ADN: ",0
	len2: equ $-entrada
	dirNum: db  '%d',0
	imp: db '%s',0
section .bss

	nombreArchivo resb 1000
	letra: resb 1000000
	numeroEntrada: resb  32


section .text
extern time
extern srand
extern rand
extern stdin
extern scanf
extern fprintf
extern printf
extern fopen
extern fclose
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
	
pedirnum:
	xor ecx,ecx
	xor ebx,ebx
	xor eax,eax
	xor edx,edx
	push entrada
	call printf
	add esp,4
	push numeroEntrada
	push dirNum
	call scanf
	add esp,8
	xor esi,esi
	mov esi,[numeroEntrada]
	dec esi
seed:
	push 0
	call time
	add esp,4
	push eax
	call srand 
	add esp,4
	xor ebx,ebx


random:
	mov ecx,27
	push ecx
	call rand
	pop ecx
	shr eax,cl
	shr eax,2
	add esp,4
	mov dl, byte[msg+eax]
	mov byte[letra+ebx],dl
 	cmp ebx,esi
 	je guardar
	inc ebx
	jmp random

guardar:
	mov eax, 8		;sys_creat
	mov ebx, nombreArchivo
	mov ecx, 0x0777		;access rights
	int 80h
	cmp eax,0

	je salir

	xor ebx,ebx
	mov ebx,eax
	
	mov eax,4
	mov ecx,letra
	mov edx,[numeroEntrada]
	int 80h

	mov eax, 6		;sys_close
	int 80h


salir:
	mov eax,1
	mov ebx,0
	int  80h 
