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
main:              ;Inicia el programa, pide al usuario que digite el nombre del archivo, para abrirlo
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
	
leerArchivo: ;lee el archivo y lo guarda en el BufferA
	push eax
	push ebx
	push bufferA
	call fgets
	add esp,18

leerIlera: ;le pide al usuario que digite la Ilera y la guarda en el bufferB
	push ilera
	Call printf
	add esp,4

	push bufferB
	push dirIlera
	call scanf
	add esp,8	
; limpia registros
xor eax,ebx
xor edx,edx
xor ebx,ebx
xor ecx,ecx
call contarBufferA ;llama a las funciones
call contarBufferB
jmp salir

contarBufferA: ;retorna en el ecx la cantidad de caracteres del BufferA
	cmp byte[bufferA+ecx],0h
	je .exit
	inc ecx
	jmp contarBufferA
	.exit:
		ret


contarBufferB: ;retorna en el edx la cantidad de caracteres del BufferB
	cmp byte[bufferB+edx],0h
	je .exit
	inc edx
	jmp contarBufferB
	
	.exit:
		ret


salir:
	mov eax,1
	mov ebx,0
	int  80h 
