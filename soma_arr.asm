	.data
	.align 0
str1:	.asciz "A soma dos elementos da lista é: "
	.align 2
arr:	.word 1, 2, 3, 4, 5
	.text
	.align 2
	.global main
	
main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	la s0, arr #coloca em s0 o endereço da arr
	addi s1, zero, 0 #soma = 0
	addi t0, zero, 5 # tam = 5 / cond parada
	addi t1, zero, 0 #cont = 0
	
#arr = s0
#soma = s1
#tam = t0
#cont = t1
soma:	
	lw t2, 0(s0) #carrega o num em t2
	
	add s1, s1, t2 #soma + t2
	addi t1, t1, 1 #cont++
	addi s0, s0, 4 #passa pro prox num do arr
	
	blt t1, t0, soma

end:	
	li a7, 1
	add a0, s1, zero
	ecall #print soma
	
	li a7, 10
	ecall #fim