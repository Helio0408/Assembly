	.data
	.align 0
str1:	.asciz "Entre com um num "
str2:	.asciz "O fatorial de "
str3:	.asciz " eh "
	.text
	.align 2
	.global main
	
main:	
	li a7, 4 #addi a7,zero,4
	la a0,str1
	ecall #printf("Entre com...")
	
	li a7, 5
	ecall #a0 está o valor digitado
	
	add s0, a0, zero  #move s0,a0
	jal fat #retorna em a1 o fatorial
	add s1, a1, zero #salva em s1 o fatorial
	li a7, 4
	la a0, str2
	ecall #as 3 linhas = printf("O fat...")
	
	li a7,1
	add a0, s0, zero
	ecall #num digitado pelo user
	
	li a7,4
	la a0, str3
	ecall #printf("eh")
	
	li a7, 1
	add a0, s1, zero
	ecall #O fat calculado
	
	li a7, 10
	ecall #encerra o código
	
fat:	
	addi a1, zero, 1 #fat = 1
	addi t0, zero, 1 #cond parada
	
lpfat:
	blt a0, t0, sailp
	mul a1, a1, a0
	addi a0, a0, -1
	j lpfat
	
sailp:
	jr ra
	