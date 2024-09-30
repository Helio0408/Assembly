	.data
	.align 0
str_src:.asciz "Hello!"
	.align 2
ptr:	.word
	.text
	.align 2
	.global main
	
main:
	#Calcular o tam de str_src
	#t3 armazena o tam da str
	addi t3, zero, 0
	
	# Coloca em t0 o endere�o
	#do 1� byte de str_src
	la t0, str_src
	
loop:	
	# L� o conteudo do byte
	#apontado por t0
	lb t2, 0(t0)
	
	#incrementa o cont t3
	addi t3, t3, 1
	
	#avan�a o pont da str_src
	addi t0, t0,1
	
	#se t2 != 0 volta no loop
	bne t2, zero, loop
	
	# Servi�o 9 da ecall aloca
	#dinamicamente bytes na heap
	#Parametro a0 = num de bytes
	#retorna em a0 o endere�o
	li a7, 9
	add a0, t3, zero
	ecall
	
	# Salva o valor reornado pela
	#ecall(a0) em ptr
	la t4, ptr
	sw a0, 0(t4)
	
	#str_copy
	# Carrega em t0 e t1 os endere�os das
	#strings origem e destino	
	la t0, str_src
	lw t1, 0(t4)
	
	# Ler o primeiro byte de str_src e
	#armazenar em t2
	lb t2, 0(t0)
	
	# Escreve t2 no 1 byte da str_dst
	sb t2, 0(t1)
	
lp:
	beq t2, zero, sai_lp
	
	# Avan�a os ponteiros das strings
	addi t0, t0, 1
	addi t1, t1, 1
	
	#L� o byte apontado por t0
	lb t2, 0(t0)
	
	#Escreve t2 no byte apontado por t1
	sb t2, 0(t1)
	
	#volta no loop
	j lp
	
sai_lp:
	#Imprimir a string copiada
	li a7, 4
	lw t1, 0(t4)
	add a0, t1, zero
	ecall
	
	#Finaliza o programa
	li a7, 10
	ecall 