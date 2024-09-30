	.data
	.align 0
str1:	.asciz "O menor numero é: "
	.align 2
arr:	.word 5, 7, 3, 8, 2
	.text
	.align 2
	.global main
	
main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	la s0, arr #coloca em s0 o endereço da arr
	lw s1, 0(s0) #min = arr[0]
	addi t0, zero, 5 # tam = 5
	addi t3, zero, 1 #cond parada
	
	addi s0, s0, 4

#arr = s0
#min = s1
#tam = t0
menor:
	addi t0, t0, -1 #tam--
	
	lw t2, 0(s0)
	blt t2, s1, nw_min

cont:	beq t0, t3, end
	addi s0, s0, 4

	j menor

nw_min:
	add s1, t2, zero
	j cont	
	
end:
	li a7, 1
	add a0, s1, zero
	ecall
	
	li a7, 10
	ecall