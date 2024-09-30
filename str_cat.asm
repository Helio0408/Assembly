	.data
	.align 0
str1:	.asciz "pinto"
str2:	.asciz "cu"
	.align 2
ptr:	.word
	.text
	.align 2
	.global main

#s0 = tam1
#s1 = tam2
#s2 = ptr
#t0 = str1
#t1 = str2
main:
	la t0, str1
	la t1, str2 #carrega str1 e 2 em t0 e t1
	
	add a0, t0, zero #a0 = st1
	addi a1, zero, 0 #a1 = contador = 0	
	jal cont
	
	add s0, a1, zero #tam1 = contador
	
	add a0, t1, zero #a0 = str2
	addi a1, zero, 0 #a1 = contador = 0
	jal cont
	
	add s1, a1, zero #tam2 = contador
	
	li a7, 9
	add a0, s0, s1
	addi a0, a0, 1
	ecall #aloca tam1+tam2+1 espaços de memoria
	
	la s2, ptr
	sw a0, 0(s2)
	
	add a0, t0, zero #a0 = st1
	add a1, s0, zero #a1 = tam1
	jal cat
	
	add a0, t1, zero #a0 = str2
	add a1, s1, zero #a1 = tam2
	jal cat
	
	addi s2, s2, 1 #vai pro ultimo espaço
	lb zero, 0(s2) #marca o fim da str com 0
	
	li a7, 4
	la a0, ptr
	ecall #print str final
	
	li a7, 10
	ecall #end

cont:
	lb t2, 0(a0) #carrega 1º byte de a0
	
	beq t2, zero, s_cont #verifica se não é o ultimo
	
	addi a0, a0, 1 #avança o ptr da str
	addi a1, a1, 1 #tam++
	
	j cont
	
s_cont:
	jr ra
	
cat:
	lb t2, 0(a0) #carrega byte da str em t2
	sb t2, 0(s2) #salva t2 na str final
	
	addi a0, a0, 1 #avança ptr da str
	addi s2, s2, 1 #avança ptr da str final
	addi a1, a1, -1 #tam--
	
	beq a1, zero, s_cat
	
	j cat
	
s_cat:
	jr ra
	
	
