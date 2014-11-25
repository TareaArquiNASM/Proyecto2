section .data
	msg: db "ACTG",0
	len: equ $-msg 
	entrada: db "Digite el largo del ADN: ",0
	len2: equ $-entrada
	dirNum: db  '%d',0
	printStr: db '%s',0
section .bss
	letra: resb 1000000
	numeroEntrada: resb  32


section .text
extern time
extern srand
extern rand
extern printf
extern stdin
extern scanf
global main

main:
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
 	je imprimir
	inc ebx
	jmp random
	;ret
imprimir:
	push letra
	;push printStr
	call printf
	add esp,8
	


salir:
	mov eax,1
	mov ebx,0
	int  80h 	
