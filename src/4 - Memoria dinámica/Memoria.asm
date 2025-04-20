extern malloc
extern free
extern fprintf

section .data
	format_str db "%s", 10, 0
	null_str db "NULL", 0

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; a[rdi], b[rsi]
strCmp:
	;prologo
	push rbp
	mov rbp, rsp

	while:
		; desreferencio los caracteres
		mov r8b, [rdi]		; r8b = A[i]
		mov r9b, [rsi]		; r9b = B[i]
		cmp r8b, r9b
		jl A_menor_a_B
		jg B_menor_a_A

		; chequear si terminaron
		cmp r8b, 0			
		je son_iguales		; if(A[i]=0=B[i]) {terminaron ambos, return 0}

		;siguiente iteracion
		inc rdi
		inc rsi
		jmp while

	A_menor_a_B:
		mov eax, 1
		jmp fin
	
	B_menor_a_A:
		mov eax, -1
		jmp fin

	son_iguales:
		mov eax, 0
	
	;epilogo
	pop rbp
	ret

; char* strClone(char* a)
strClone:
	;prologo
	push rbp
	mov rbp, rsp
	sub rsp, 16			; PILA ALINEADA
	mov [rbp-8], r12
	mov [rbp-16], r13
	mov r12, rdi		; r12 = *a

	xor rax, rax
	call strLen			; rax = strLen(a)
	inc rax				; rax = strLen(a)+1 // por el '/0'
	mov r13, rax		; r13 = strLen(a)+1

	; reservo memoria
	mov rdi, rax
	call malloc
	mov r9, rax		; r9 = *copy_a, rax no lo voy a mover para poder devolver puntero al primer char

	loop:
		mov r10b, [r12]
		mov [r9], r10b	; copy_a[i]=a[i]

		; siguiente iteracion
		inc r12
		inc r9

		dec r13
		jnz loop

	;epilogo
	mov r12, [rbp-8]
	mov r13, [rbp-16]
	add rsp, 16
	pop rbp
	ret

; void strDelete(char* a)
strDelete:
	;prologo
	push rbp
	mov rbp, rsp

	call free

	;epilogo
	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
; a[rdi]
; pFile[rsi]
strPrint:
	;prologo
	push rbp
	mov rbp, rsp
	
	; Preparo los argumentos para fprintf
	mov r8, rdi				
	mov rdi, rsi			; rdi = &pFile
	mov rdx, r8				; rdx = &a
	lea rsi, [format_str]	; rsi = &format_str // lea carga la direccion de format_str, no el valor

	cmp byte [rdx], 0
	jne imprimir

	; Si a = "", imprimir NULL
	lea rdx, [null_str]	; rdx = &format_str 

	imprimir:
	call fprintf

	;epilogo
	pop rbp
	ret

; uint32_t strLen(char* a)
strLen:
	;prologo
	push rbp
	mov rbp, rsp
	
	xor eax, eax			; eax = contador = 0
	while2:
		mov r8b, [rdi]		; r8b = A[i]
		
		; chequeo si terminó
		cmp r8b, 0
		je fin

		; siguiente iteracion
		inc eax				; contador++
		inc rdi
		jmp while2

	fin:
	;epilogo
	pop rbp
	ret


