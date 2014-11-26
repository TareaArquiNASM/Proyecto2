section .data
open: db 'r',0
nombre: db 'Cual es el nombre del archivo? ',0
ilera: db 'Digite la Ilera (por favor usar letras MAYUSCULAS A,C,T,G) ',0
dirNom: db '%s',0
dirIlera: db '%s',0 

section .bss
bufferA resb 10000
bufferB resb 10000
nombreArchivo resb 1000

section .text
extern printf
extern scanf
extern fopen
extern fgets
global main
main:
	push nombre
	Call printf
	add esp,4

	push nombreArchivo
	push dirNom
	call scanf
	add esp,8

	push open
	push nombreArchivo
	call fopen
	add esp,8
	mov ebx,1000000
	
leerArchivo:
	push eax
	push ebx
	push bufferA
	call fgets
	add esp,18

leerIlera:
	push ilera
	Call printf
	add esp,4

	push bufferB
	push dirIlera
	call scanf
	add esp,8	


escribir:
	mov eax,4
	mov ebx,1
	mov ecx,bufferB
	mov edx,1000000
	int 80h

salir:
	mov eax,1
	mov ebx,0
	int  80h 
