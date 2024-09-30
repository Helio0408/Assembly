	.data
	.align 0
str_src:.asciz "Hello!"
str_dst:.space 7
	.text
	.align 2
	.global main
	
main:	
	# Carrega em t0 e t1 os endereços das
	#strings origem e destino	
	la t0, str_src
	la t1, str_dst
	
	# Ler o primeiro byte de str_src e
	#armazenar em t2
	lb t2, 0(t0)
	
	# Escreve t2 no 1 byte da str_dst
	sb t2, 0(t1)
	
loop:
	beq t2, zero, sai_lp
	
	# Avança os ponteiros das strings
	addi t0, t0, 1
	addi t1, t1, 1
	
	#Lê o byte apontado por t0
	lb t2, 0(t0)
	
	#Escreve t2 no byte apontado por t1
	sb t2, 0(t1)
	
	#volta no loop
	j loop
	
sai_lp:
	#Imprimir a string copiada
	li a7, 4
	la a0, str_dst
	ecall
	
	#Finaliza o programa
	li a7, 10
	ecall 