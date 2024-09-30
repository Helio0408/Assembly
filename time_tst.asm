	.data
	.align 0
str1:	.asciz "O seu numero aleatorio é: "
	.text
	.align 2
	.global main
	
#x = rand
#a = 50
#c = 51
#m = 101
main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	li a7, 42
	addi a1, zero, 101 
	ecall #gera rand entre 0 e 101
	
	add s0, a0, zero #salva rand
	
	jal gcl #res = a1
	
	add a0, a1, zero
	li a7, 1
	ecall #print res
	
	li a7, 10
	ecall #fim prog
	
# x' = (a*x + c)mod m
# x' = a1
# x = a0
gcl:
	addi t0, zero, 50 #a = t0
	addi t1, zero, 51 #c = t1
	addi t2, zero, 101 #m = t2

	mul t3, t0, a0 #t3 = a*x
	add t3, t3, t1 #t3 = t3 + c = a*x + c
	rem a1, t3, t2 #x' = t3 mod m = (a*x + c)mod m
	
	beq a1, zero, gcl #se x' for 0, escolhe outro num
	
	jr ra