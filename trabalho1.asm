# Trabalho realizado pelos alunos:
# Hélio Márcio Cabral Santos - NUSP: 14577862
# Gabriel Martins Monteiro - NUSP: 14572099
# Eduardo Pereira de Luna Freire - NUSP: 14567304
# Andrey Cortez Rufino - NUSP: 11819487

#Instruções de compilação e execução no readme.txt
	.data
	.align 0
str1:	.asciz "Bem vindo ao jogo\nTente adivinhar o numero\nCada numero inserido será testado, um a um\nAgora digite um numero\n"
str2:	.asciz "Parabens voce acertou o numero\nNumero de tentativas: "
str3:	.asciz "Palpite muito alto\n"
str4:	.asciz "Palpite muito baixo\n"
str5:	.asciz "\nSuas tentativas foram: "
str6:	.asciz ", "
	.align 2
ptr:	.word
	.text
	.align 2
	.global main
	
#s0 = valor alvo
#s1 = entrada do user
#s2 = contador
#s3 = rand
#ptr = ini da lista
#s4 = atual da lista
main:
	li a7, 4 # número da ecall para print
	la a0, str1
	ecall #print str1
	
	li a7, 42 # número da ecall que gera números aleatórios
	addi a1, zero, 101 
	ecall #gera rand entre 0 e 101
	
	add s3, a0, zero #salva rand
	
	jal gcl #res = a1
	
	add s3, a1, zero #rand = res
	
	li a7, 9
	addi a0, zero, 8
	ecall #aloca 2 espacos iniciais
	
	la s4, ptr #salva o endereço de ptr em s4
	sw a0, 0(s4) #salva o espaço alocado
	
	addi s2, zero, 0 #cont = 0
	add s0, s3, zero #condição de parada
	
loop:
	li a7, 5
	ecall #scan entrada num
	
	add s1, a0, zero #salva a entrada
	
	li a7, 9 # número da ecall para alocar memória na heap
	addi a0, zero, 8
	ecall #aloca 2 espaços e retorna em a0
	
	sw s1, 0(s4) #salva o val
	sw a0, 4(s4) #salva o prox
	
	add s4, a0, zero #atual = prox
	addi s2, s2, 1 #cont++
	
	beq s1, s0, fim_lp #se a entrada for igual ao alvo sai do loop
	bgt s1, s0, maior #se a entrada for maior que o alvo, desvia
	blt s1, s0, menor #se a entrada for menor que o alvo, desvia
	
maior:
	li a7, 4
	la a0, str3
	ecall #print str3
	
	j loop #recomeça o loop

menor:
	li a7, 4
	la a0, str4
	ecall #print str4
	
	j loop #recomeça o loop
		
fim_lp:
	li a7, 4
	la a0, str2
	ecall #print str2
	
	li a7, 1
	add a0, s2, zero
	ecall #print do numero de tentativas
	
	li a7, 4
	la a0, str5
	ecall #print str5
	
	la s4, ptr #reset de s4 (elemento atual da lista)
	
	j print #jump p/ loop de imprimir array
		
print:
	addi t0, zero, 1 #condição de parada
	
	lw t1, 0(s4) #recupera o val
	lw s4, 4(s4) #atual = prox
	
	li a7, 1
	add a0, t1, zero
	ecall #print val
	
	li a7, 4
	la a0, str6
	ecall #print str6
	
	addi s2, s2, -1 #tam--
	
	bgt s2, t0, print # se o tamanho for maior que a condição de parada, voltar para a label print

fim_pr:
	li a7, 1
	add a0, s0, zero
	ecall #print alvo p/ completar a lista de palpites
	
	li a7,10
	ecall #encerra o programa
	
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
	
	jr ra # volta para o endereço de chamada