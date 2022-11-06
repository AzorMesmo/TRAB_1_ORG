# PADRAO DOS REGISTRADORES

# a0 = INPUTS
# a4 = MATRIZ QUANDO EM FUNÇÕES
# a7 = CHAMADAS DOS SISTEMAS
	
# a2 = TAMANHO DAS LINHAS DA MATRIZ
# a3 = QUANTIDADE DE ELEMENTOS DA MATRIZ

# t0 = CONTADOR UM
# t1 = CONTADOR DOIS


	.data

wrd_numbers:
	.word	0, 1, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0
wrd_determinante:
	.word   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str_space:
	.string	" "
str_break:
	.string "\n"
str_number:
	.string "Number: "
str_size:
	.string "Size: "
str_max:  
	.string "Max: "
str_menu:
	.string "1- Input\n2- Print\n3- Max\n4- Ordena\n5- Determinante\n6- Sair\n"
str_option:
	.string "Option: "
str_else:
	.string "This option is not available!\n"

	.text
	
# funcao main -> inicio do programa
	
main:
	la a0, wrd_numbers # coloca o {wrd_numbers} em a1
	addi a1, zero, 6
	addi s8, a0, 0

loop_main:
	call break
	
	addi s1, zero, 1
	addi s2, zero, 2
	addi s3, zero, 3 #confere option
	addi s4, zero, 4
	addi s5, zero, 5
	addi s6, zero, 6
	
	la a0, str_menu #imprime menu de opcoes de operacoes
	li a7, 4
	ecall
	
	la a0, str_option #imprime "Option: "
	li a7, 4
	ecall
	
	li a7, 5 #lê option
	ecall
	
	mv s0, a0 #move a option para s0
	
	call reset #a0 volta a ter a lista
	
	beq s0, s6, end #se option == 6, encerra programa

	if_option1:
		bne s0, s1, if_option2
		call input # chama a funcao {input}
		j loop_main
	if_option2:
		bne s0, s2, if_option3
		call print # chama a funcao {print}
		j loop_main
	if_option3:
		bne s0, s3, if_option4
		call max # chama a funcao {max}
		j loop_main
	if_option4:
		bne s0, s4, if_option5
		call ordena_matriz # chama a funcao {ordena_matriz}
		j loop_main
	if_option5:
		bne s0, s5, else
		call determinante # chama a funcao {determinante}
		j loop_main
	else:
		la a0, str_else
		li a7, 4
		j loop_main
	
# funcao reset -> retorna o ponteiro da matriz para o inicio

reset:
	addi a0, s8, 0
	ret # retorna
	
# funcao break -> imprime uma quebra de linha

break:
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	ret # retorna
	
# funcao input -> le os valores da matriz
	
input:
	addi a4, a0, 0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_size # coloca o {str_size} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t0, zero, 7 # coloca o valor 7 em t0 (para um tamanho maximo da matriz igual a 6)
	addi t1, zero, 2 # coloca o valor 2 em t1 (para um tamanho maximo da matriz igual a 2)
	blt a0, t1, end # desvia (encerra o programa) se a0 for menor que t1
	bge a0, t0, end # desvia (encerra o programa) se a0 for maior ou igual a t0
	
	mul a3, a0, a0 # faz o tamanho da matriz ao quadrado para obter o numero de elementos e coloca esse valor em a3
	addi t0, a3, 0 # coloca o valor de a3 em t0 (contador dos numeros a serem lidos)
	
	mv a1, a0 # move a0 (quantidade de elementos por linha) para a2
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_break # coloca o {str_break} em a0
i_loop:
	bge zero, t0, i_end # desvia se t0 (contador dos numeros a serem lidos) for menor ou igual a 0 ("maior ou igual" invertido)
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_number # coloca o {str_number} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	sw a0, 0(a4) # move o valor de a0 para a1
	addi a4, a4, 4 # vai para o proximo valor de a1 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador
	j i_loop # desvia para {i_loop}
i_end:
	ret # retorna
							
# funcao print -> imprimi a matriz

print:
	addi a4, a0, 0
	addi t0, a3, 0 # contador do tamanho da matriz (t0 recebe o numero de elementos da matriz)
	addi t1, a1, 0 # contador das quebras de linha (t1 recebe o tamanho da linha da matriz)
p_loop:
	beq t1, zero, p_break # desvia se t1 (contador das quebras de linha) for igual a 0
	bge zero, t0, p_end # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	
	lw a0, 0(a4) # coloca em a0 o conteudo de a1 (o primeiro elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_space # coloca o {str_space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi a4, a4, 4 # vai para o proximo valor de a1 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador do tamanho da matriz
	addi t1, t1, -1 # decrementa o contador das quebras de linha

	j p_loop # desvia para {p_loop}
p_break:
	la a0, str_break # coloca {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t1, a1, 0 # reinicia o contador em t1 (contador das quebras de linha)
	
	j p_loop # desvia para {p_loop}
p_end:
	ret # retorna
	
# funcao max -> acha o maior valor da matriz
	
max: #ARRUMAR PARA RETORNAR LINHA + 1 E COLUNA + 1, E RETORNAR NOS REGISTRADORES CERTOS
	addi a4, a0, 0
	addi t0, zero, 1 # contador de numeros verificados (comeca em 1 porque antes de entrar no loop verificaremos um numero)
	
	addi t2, zero, 0 # armazena a linha do maior elemento (comeca em 0)
	addi t3, zero, 0 # armazena a coluna do maior elemento (comeca em 0)
	addi t4, zero, 0 # armazena a linha do elemento atual (comeca em 0)
	addi t5, zero, 0 # armazena a coluna do elemento atual (comeca em 0)
	
	lw s0, 0(a4) # coloca o primeiro elemento da lista em s0
	add t6, zero, s0 # define o primeiro numero como valor maximo e o coloca em t6
m_loop:
	bge t0, a3, m_end # desvia se t0 (contador dos numeros verificados) for maior ou igual a a3 (quantidade de elementos no vetor)
	
	addi a4, a4, 4 # vai para o proximo valor de a1 (adicionando 4)
	lw s0, 0(a4) # coloca o proximo elemento da lista em s0
	
	addi t0, t0, 1 # incrementa o contador de numeros verificados
	addi t5, t5, 1 # incrementa o valor da coluna atual em 1
	
	blt s0, t6, verifica_c # desvia se s0 (numero lido) for menor que t6 (valor maximo armazenado)
	mv t6, s0 # move o valor de s0 (numero lido) para t6 (valor maximo armazenado)
	mv t2, t4 # move o valor de t4 (linha do elemento atual) para t2 (linha do maior elemento)
	mv t3, t5 # move o valor de t5 (coluna do elemento atual) para t3 (coluna do maior elemento)
	
verifica_c:
	blt t5, a1, m_loop
	add t5, zero, zero
	addi t4, t4, 1 # incrementa o valor da linha atual em 1
	
	j m_loop # desvia para {m_loop}
m_end:
	la a0, str_max # coloca o {str_max} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a
	
	add a0, zero, t6 # coloca em a0 o conteudo de t6 (o maior elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	ret # retorna
	
	
ordena_matriz: #ARRUMAR COMENTÁRIOS E REGISTRADORES USADOS, ESTÁ TUDO BAGUNÇADO?????????????
	addi a4, a0, 0
	addi t6, a0, 0 #posicao atual da ordenacao
	addi s1, zero, 0 #contador de numeros ordenados
	addi s6, a3, 0
	
ordena_loop:
	bge s1, a3, ordena_end # desvia se s1 (contador dos numeros ordenados) for maior ou igual a a3 (quantidade de elementos no vetor)
	addi s1, s1, 1 #incrementa contador de numeros ordenados
	
encontra_min: #retorna min em s2 e sua posicao em t1
	addi t0, zero, 1 # contador de numeros verificados (comeca em 1 porque antes de entrar no loop verificaremos um numero)
	
	addi t1, a4, 0 # armazena a posicao do menor elemento
	
	lw s0, 0(a4) # coloca o primeiro elemento da lista em s0
	add t3, zero, s0 # define o primeiro numero como valor minimo e o coloca em t3
	
min_loop:
	bge t0, s6, min_end # desvia se t0 (contador dos numeros verificados) for maior ou igual a a3 (quantidade de elementos no vetor)
	
	addi a4, a4, 4 # vai para o proximo valor de a1 (adicionando 4)
	lw s0, 0(a4) # coloca o proximo elemento da lista em s0
	
	addi t0, t0, 1 # incrementa o contador de numeros verificados
	
	bge s0, t3, min_loop # desvia se t3 (valor minimo armazenado) for menor que s0 (valor lido)

	mv t3, s0 #move o valor de s0 (valor atual) para t3 (menor elemento)
	addi t1, a4, 0 #posicao atual da ordenacao
	
	j min_loop # desvia para {m_loop}
min_end:
	add s2, zero, t3 # coloca em s2 o conteudo de t3 (o menor elemento da lista) 
	add a0, s2, zero
	
troca_valores: #t1 = posicao do menor elemento, #t6 = posicao atual da ordenacao
	lw s3, 0(t6) #numero a trocar com o menor
	lw s4, 0(t1) #numero a trocar com o da posicao atual
	
	addi a4, t1, 0
	sw s3, 0(a4) #coloca o valor atual na posicao do menor
	
	addi a4, t6, 0
	sw s4, 0(a4) #coloca o menor na posicao atual
	
	addi a4, a4, 4
	addi t6, a4, 0
	addi s6, s6, -1
	
	j ordena_loop


ordena_end:
	ret
	
determinante:
	la s0, wrd_determinante
	addi s1, zero, 0
	addi t6, a1, 0
	addi s7, s0, 0
	
loop1_determinante:
	bge s1, a2, nextOnes_determinante
	
	addi s1, s1, 1
	
	lw a0, 0(a1)
	sw a0, 0(s0)
	
	addi a1, a1, 16
	addi s0, s0, 4
	
	
	
	j loop1_determinante

nextOnes_determinante:
	addi a1, t6, 4
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 16
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 4
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, t6, 8
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 4   
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 16
	lw a0, 0(a1)
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, t6, 4
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 8
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 20
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, t6, 0
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 20
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 8
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, t6, 8
	lw a0, 0(a1)     
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 8
	lw a0, 0(a1)
	sw a0, 0(s0)
	addi s0, s0, 4
	addi a1, a1, 8
	lw a0, 0(a1)
	sw a0, 0(s0)
	
print_determinante:
	addi t1, zero, 0
	addi t2, zero, 18
	addi s0, s7, 0
loop_print_determinante:
	bge t1, t2, end_determinante
	
	lw a0, 0(s0)
	li a7, 1
	ecall
	
	addi s0, s0, 4
	
	addi t1, t1, 1
	j loop_print_determinante
	
loop_calcula_determinante:

next_determinante:
	addi s0, s7, 0
	addi t1, zero, 1
	addi s1, zero, 0
	
mul_determinante:
	bge s1, a2, end_determinante
	
	lw a0, 0(s0)
	
	addi s0, s0, 4
	addi s1, s1, 1
	
	mul t1, t1, a0 
	
	j mul_determinante
	

end_determinante:
#	mv a0, t1
	ret
	

	
# função end -> encerra o programa
end:
	li a7, 10 # coloca o valor 10 em a7 (10 = finalizar programa)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)	
