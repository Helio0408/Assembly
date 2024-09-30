	.data
	.align 0
str1:	.asciz "Escreva um numero: "
str2:	.asciz "O fatorial desse numero é: "
	.text
	.align 2
	.global main

# num = s0
main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	li a7, 5
	ecall #pega entrada do user
	
	add s0, a0, zero #salva entrada em s0
	
	jal fat #retorna em a1 o resultado

	li a7, 4
	la a0, str2
	ecall #print str2
	
	li a7, 1
	add a0, a1, zero
	ecall
	
	li a7, 10
	ecall #finaliza prog
	
# função recursiva
# num = a0
# res = a1
fat:
	addi sp, sp, -8
	sw ra, 0(sp) #empilha o ra
	sw a0, 4(sp) #empilha o a0
	
	beq a0, zero, return1 #sai da função quando num = 0
	
	addi a0, a0, -1 #num--
	
	jal fat #chamada recursiva
	
	lw a0, 4(sp) #recupera o valor de a0
	mul a1, a1, a0 #res = res * num
	
	j sai_fat
	
return1:
	addi a1, zero, 1
	
sai_fat:
	lw ra, 0(sp)
	addi sp, sp, 8
	jr ra
	
	
