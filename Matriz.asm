# PADRAO DOS REGISTRADORES

# a0 = INPUTS
# a1 = TAMANHO DAS LINHAS/CULUNAS DA MATRIZ
# a3 = QUANTIDADE DE ELEMENTOS DA MATRIZ
# a4 = MATRIZ QUANDO EM FUNÇÕES
# a7 = CHAMADAS DOS SISTEMAS

# t0 = CONTADOR UM
# t1 = CONTADOR DOIS

	.data

wrd_numbers:
	.word	0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0
wrd_determinante:
	.word   0, 0, 0, 0, 0, 0, 0, 0, 0
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
str_line:
	.string "Line: "
str_column:
	.string "Column: "
str_sorted:
	.string "\nMatrix Sorted!\n"
str_menu:
	.string "1- Input\n2- Print\n3- Max\n4- Ordena\n5- Determinante\n0- Sair\n"
str_option:
	.string "Option: "
str_invalid:
	.string "Invalid Option!\n"

	.text
	
# funcao main -> inicio do programa
	
main:
	la a0, wrd_numbers # coloca o {wrd_numbers} em a0
	addi a1, zero, 6 # coloca o valor 6 em a1
	addi s8, a0, 0 # guarda o inicio da matriz em s8
main_loop:
	addi s1, zero, 1 # coloca o valor 1 em s1 (opcao 1)
	addi s2, zero, 2 # coloca o valor 2 em s2 (opcao 2)
	addi s3, zero, 3 # coloca o valor 3 em s3 (opcao 3)
	addi s4, zero, 4 # coloca o valor 4 em s4 (opcao 4)
	addi s5, zero, 5 # coloca o valor 5 em s5 (opcao 5)
	
	la a0, str_menu # coloca o {str_menu} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_option # coloca o {str_option} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	mv s0, a0 # move o valor da opcao escolhida para s0
	
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi a0, s8, 0 # coloca em a0 o valor de s8 (inicio da matriz)

	main_exit:
		bne s0, zero, main_input # desvia se s0 igual a 0
		call end # chama a funcao {end}
		j main_loop # desvia para {main_loop}
	main_input:
		bne s0, s1, main_print # desvia se s0 igual a s1
		call input # chama a funcao {input}
		j main_loop # desvia para {main_loop}
	main_print:
		bne s0, s2, main_max # desvia se s0 igual a s2
		call print # chama a funcao {print}
		j main_loop # desvia para {main_loop}
	main_max:
		bne s0, s3, main_sort # desvia se s0 igual a s3
		call max # chama a funcao {max}
		j main_loop # desvia para {main_loop}
	main_sort:
		bne s0, s4, main_det # desvia se s0 igual a s4
		call sort # chama a funcao {ordena_matriz}
		j main_loop # desvia para {main_loop}
	main_det:
		bne s0, s5, main_invalid # desvia se s0 igual a s5
		call determinante # chama a funcao {determinante}
		j main_loop # desvia para {main_loop}
	main_invalid:
		la a0, str_invalid # coloca o {str_invalid} em a0
		li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
		ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
		
		la a0, str_break # coloca o {str_break} em a0
		li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
		ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
		
		j main_loop # desvia para {main_loop}
	
# funcao reset -> retorna o ponteiro da matriz para o inicio

reset:
	addi a0, s8, 0 # coloca em a0 o valor de s8 (inicio da matriz)
	ret # retorna
	
# funcao input -> le os valores da matriz
	
input:
	addi a4, a0, 0 # coloca o valor de a0 (endereço incial da matriz) em a4
	
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
	
	mv a1, a0 # move a0 (quantidade de elementos por linha/coluna) para a1
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_break # coloca o {str_break} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
i_loop:
	bge zero, t0, i_end # desvia se t0 (contador dos numeros a serem lidos) for menor ou igual a 0 ("maior ou igual" invertido)
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_number # coloca o {str_number} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	sw a0, 0(a4) # move o valor de a0 para a4
	addi a4, a4, 4 # vai para o proximo valor de a4 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador
	j i_loop # desvia para {i_loop}
i_end:
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)

	ret # retorna
							
# funcao print -> imprimi a matriz

print:
	addi a4, a0, 0 # coloca o valor de a0 (endereço incial da matriz) em a4
	addi t0, a3, 0 # contador do tamanho da matriz (t0 recebe o numero de elementos da matriz)
	addi t1, a1, 0 # contador das quebras de linha (t1 recebe o tamanho da linha da matriz)
p_loop:
	beq t1, zero, p_break # desvia se t1 (contador das quebras de linha) for igual a 0
	bge zero, t0, p_end # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	
	lw a0, 0(a4) # coloca em a0 o conteudo de a4 (o primeiro elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_space # coloca o {str_space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi a4, a4, 4 # vai para o proximo valor de a4 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador do tamanho da matriz
	addi t1, t1, -1 # decrementa o contador das quebras de linha

	j p_loop # desvia para {p_loop}
p_break:
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t1, a1, 0 # reinicia o contador em t1 (contador das quebras de linha)
	
	j p_loop # desvia para {p_loop}
p_end:
	la a0, str_break # coloca {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)

	ret # retorna
	
# funcao max -> acha o maior valor da matriz
	
max:
	addi a4, a0, 0 # coloca o valor de a0 (endereço incial da matriz) em a4
	addi t0, zero, 1 # contador de numeros verificados (comeca em 1 porque antes de entrar no loop verificamos um numero)
	
	addi t2, zero, 1 # armazena a linha do maior elemento (comeca em 1)
	addi t3, zero, 1 # armazena a coluna do maior elemento (comeca em 1)
	addi t4, zero, 1 # armazena a linha do elemento atual (comeca em 1)
	addi t5, zero, 1 # armazena a coluna do elemento atual (comeca em 1)
	
	lw s0, 0(a4) # coloca o primeiro elemento da lista em s0
	add t6, zero, s0 # define o primeiro numero como valor maximo e o coloca em t6
m_loop:
	bge t0, a3, m_end # desvia se t0 (contador dos numeros verificados) for maior ou igual a a3 (quantidade de elementos no vetor)
	
	addi a4, a4, 4 # vai para o proximo valor de a4 (adicionando 4)
	lw s0, 0(a4) # coloca o proximo elemento da lista em s0
	
	addi t0, t0, 1 # incrementa o contador de numeros verificados
	addi t5, t5, 1 # incrementa o valor da coluna atual em 1
	
	blt s0, t6, m_next # desvia se s0 (numero lido) for menor que t6 (valor maximo armazenado)
	mv t6, s0 # move o valor de s0 (numero lido) para t6 (valor maximo armazenado)
	mv t2, t4 # move o valor de t4 (linha do elemento atual) para t2 (linha do maior elemento)
	mv t3, t5 # move o valor de t5 (coluna do elemento atual) para t3 (coluna do maior elemento)
m_next:
	blt t5, a1, m_loop # desvia se t5 (coluna do elemento atual) for menor que a1 (quantidade de elementos por linha)
	addi t5, zero, 0 # reinicia o contador
	addi t4, t4, 1 # incrementa o valor da linha atual em 1
	
	j m_loop # desvia para {m_loop}
m_end:
	la a0, str_max # coloca o {str_max} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a
	
	add a0, zero, t6 # coloca em a0 o conteudo de t6 (o maior elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_line # coloca o {str_line} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a
	
	add a0, zero, t2 # coloca em a0 o conteudo de t6 (o maior elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_column # coloca o {str_column} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a
	
	add a0, zero, t3 # coloca em a0 o conteudo de t6 (o maior elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_break # coloca {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	ret # retorna
	
# funcao sort -> ordena a matriz em ordem crescente
	
sort:
	addi a4, a0, 0 # coloca o valor de a0 (endereço incial da matriz) em a4
	
	addi s0, a0, 0 # coloca em s0 o numero na posicao atual
	
	addi t0, zero, 0 # contador de numeros ordenados
	addi t1, a3, 0 # contador da quantidade de elementos a verificar
s_loop:
	bge t0, a3, s_end # desvia se t0 (contador de numeros ordenados) for maior ou igual a a3 (quantidade de elementos na matriz)
	
	addi t0, t0, 1 # incrementa contador de numeros ordenados
s_min:
	addi t2, zero, 1 # contador de numeros verificados (comeca em 1 porque antes de entrar no loop verificamos um numero)
	
	addi s1, a4, 0 # armazena a posicao do menor elemento em s1
	
	lw t3, 0(a4) # coloca o primeiro elemento da lista em t3
	add s2, zero, t3 # define o primeiro elemento como valor minimo e o coloca em s2
s_min_loop:
	bge t2, t1, s_switch # desvia se t2 (contador dos numeros verificados) for maior ou igual a t1 (contador da quantidade de elementos a verificar)
	
	addi a4, a4, 4 # vai para o proximo valor de a4 (adicionando 4)
	lw t3, 0(a4) # coloca o proximo elemento da lista em t3
	
	addi t2, t2, 1 # incrementa o contador de numeros verificados
	
	bge t3, s2, s_min_loop # desvia se t3 (valor minimo armazenado) for menor que s0 (valor lido)

	mv s2, t3 # move o valor de t3 (elemento atual) para s2 (menor elemento)
	addi s1, a4, 0 # guarda a posicao atual da ordenacao em s1
	
	j s_min_loop # desvia para {s_min_loop}
s_switch:
	add a0, s2, zero # coloca em a0 o conteudo de s2 (menor elemento da lista)

	lw t5, 0(s0) # armazena o valor no endereço de s0 (numero a ser trocado com o menor) em t5
	lw t6, 0(s1) # armazena o valor no endereco de s1 (numero a ser trocado com o da posicao atual) em t6
	
	addi a4, s1, 0 # coloca em a4 o valor de s1 (posicao do numero a ser trocado com o da posicao atual)
	sw t5, 0(a4) # coloca o valor de t5 na posicao de a4 (valor atual na posicao do menor)
	
	addi a4, s0, 0 # coloca em a4 o valor de s0 (posicao do numero a ser trocado com o menor)
	sw t6, 0(a4) # coloca o valor de t6 na posicao de a4 (antigo valor menor na posicao do atual)
	
	addi a4, a4, 4 # vai para o proximo valor de a4 (adicionando 4)
	addi s0, a4, 0 # reinicia a posicao atual da ordenacao (comeca um valor a frente pois ja achamos o menor valor)
	addi t1, t1, -1 # decrementa o contador da quantidade de elementos a verificar
	# addi t0, t0, 1 # incrementa contador de numeros ordenados
	
	j s_loop # desvia para {s_loop}
s_end:
	la a0, str_sorted # coloca o {str_number} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)

	ret # retorna

# funcao det -> calcula a determinante da matriz

det:
	

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
