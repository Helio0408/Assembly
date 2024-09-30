	.data
	.align 0
str1:	.asciz "Qual o tamalho da lista?"
str2:	.asciz "Escreva os números um por um:\n"
spc:	.asciz " "
	.align 2
ptr:	.word
	.text
	.align 2
	.global main
	
main:
	li a7, 4
	la a0, str1
	ecall #print str1
	
	li a7, 5
	ecall #num = a0
	
	add t2, a0, zero #salva num
	
	li a7, 9
	addi t0, zero, 4
	mul a0, a0, t0 #num * 4
	ecall #aloca num espaços
	
	la t3, ptr
	sw a0, 0(t3) #ptr -> arr
	
	li a7, 4
	la a0, str2
	ecall #print str2
	
	addi s0, zero, 0 #aux = 0
	add s1, t2, zero #max = num /cond parada
	addi t0, zero, 0 #i = 0
	addi t1, s1, -1 #j = max-1
	addi t2, zero, 0 #cont = 0

input:
	li a7, 5
	ecall #entrada = a0
	
	sw a0, 0(t3) #salva entrada no arr
	addi t3, t3, 4 #t3 + 4
	
	addi t2, t2, 1 #cont++
	
	blt t2, s1, input #se cont < max repete
	
	addi s4, t3, -4 #salva o endereço do ultimo elemento

#aux = s0
#max = s1
#arr = s2
#fim_arr = s4
#i = t0
#j = t1
sort:
	j for_i

s_sort:	
	addi t2, zero, 0 #cont = 0
	la t3, ptr
	
	j print

for_i:
	addi t1, s1, -1 #reset valor j
	add t2, s4, zero #reset endereço t2
	add s3, ra, zero #salva valor de ra
	
	jal for_j
	
	addi t0, t0, 1 #i++
	
	blt t0, s1, for_i
	
	j s_sort

for_j:	
	lw t4, -4(t2) #num[j-1] = t4
	lw t5, 0(t2) #num[j] = t5
	
	ble t4, t5, if_fal
	
	add s0, t4, zero #aux = num[j-1]
	add t4, t5, zero #num[j - 1] = num[j]
	add t5, s0, zero #num[j] = aux
	
	sw t4, -4(t2) 
	sw t5, 0(t2) #salva as mudanças

if_fal:

	addi t2, t2, -4 #volta uma pos do arr
	addi t1, t1, -1 #j--
	
	bgt t1, t0, for_j
	
	jr ra
	
print:
	li a7, 1
	lw a0, 0(t3)
	ecall #print arr
	
	li a7, 4
	la a0, spc
	ecall #print espaço
	
	addi t3, t3, 4 #t3 + 4
	
	addi t2, t2, 1 # cont++
	
	blt t2, s1, print
	
end:
	li a7, 10
	ecall #end