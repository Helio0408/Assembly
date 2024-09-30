	.data
	.align 0
str1:	.asciz "Escreva numeros: "
	.align 2
ptr:	.word
	.text
	.align 2
	.global main

main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	li a7, 9
	addi a0, zero, 8
	ecall #aloca 2 espacos iniciais
	
	la t0, ptr #salva o endereço de ptr em t0
	sw a0, 0(t0) #salva no espaço apontado por ptr
	
	addi s0, zero, 0 #num = 0
	addi t2, zero, 5 #cond parada

#s0 = tam
#a0 = prox
#t0 = atual
#t1 = val
loop:
	li a7, 5
	ecall #a0 = entrada
	
	add t1, a0, zero #salva a entrada em t1
	
	addi s0, s0, 1 #num++
	
	li a7, 9
	addi a0, zero, 8
	ecall #aloca 2 espaços e retorna em a0
	
	sw t1, 0(t0) #salva o val
	sw a0, 4(t0) #salva o prox
	
	add t0, a0, zero #atual = prox
	
	blt s0, t2, loop
	
	la t0, ptr #reset de t0
	
print:
	lw t1, 0(t0) #recupera o val
	lw t0, 4(t0) #atual = prox
	
	li a7, 1
	add a0, t1, zero
	ecall #print val
	
	addi s0, s0, -1 #tam--
	
	bgt s0, zero, print
	
	li a7, 10
	ecall