# PADRAO DOS REGISTRADORES

# a0 = INPUTS
# a7 = CHAMADAS DOS SISTEMAS
	
# a2 = TAMANHO DAS LINHAS DA MATRIZ
# a3 = QUANTIDADE DE ELEMENTOS DA MATRIZ

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

	.text
	
# funcao main -> inicio do programa
	
main:
	la a1, wrd_numbers # coloca o {wrd_numbers} em a1
	call input # chama a funcao {input}
	call reset # chama a funcao {reset}
	call break # chama a funcao {break}
	call print # chama a funcao {print}
	call reset # chama a funcao {reset}
	call break # chama a funcao {break}
	call max # chama a funcao {max}
	call end # chama a funcao {end}

# funcao reset -> retorna o ponteiro da matriz para o inicio
	
reset:
	addi t0, a3, 0 # coloca em t0 (contador do retorno do ponteiro) o tamanho da matriz
	
r_loop:
	bge zero, t0, r_end # desvia se t0 (contador do retorno do ponteiro) for menor ou igual a zero ("maior ou igual" invertido)
	
	addi a1, a1, -4 # retorna o ponteiro
	addi t0, t0, -1 # decrementa o contador
	
	j r_loop # desvia para {r_loop}
r_end:
	ret # retorna
	
# funcao break -> imprime uma quebra de linha

break:
	la a0, str_break # coloca o {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	ret # retorna
	
# funcao input -> le os valores da matriz
	
input:
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
	
	mv a2, a0 # move a0 (quantidade de elementos por linha) para a2
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_break # coloca o {str_break} em a0
i_loop:
	bge zero, t0, i_end # desvia se t0 (contador dos numeros a serem lidos) for menor ou igual a 0 ("maior ou igual" invertido)
	
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_number # coloca o {str_number} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	sw a0, 0(a1) # move o valor de a0 para a1
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador
	j i_loop # desvia para {i_loop}
i_end:
	ret # retorna
							
# funcao print -> imprimi a matriz

print:
	addi t0, a3, 0 # contador do tamanho da matriz (t0 recebe o numero de elementos da matriz)
	addi t1, a2, 0 # contador das quebras de linha (t1 recebe o tamanho da linha da matriz)
p_loop:
	beq t1, zero, p_break # desvia se t1 (contador das quebras de linha) for igual a 0
	bge zero, t0, p_end # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	
	lw a0, 0(a1) # coloca em a0 o conteudo de a1 (o primeiro elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_space # coloca o {str_space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador do tamanho da matriz
	addi t1, t1, -1 # decrementa o contador das quebras de linha

	j p_loop # desvia para {p_loop}
p_break:
	la a0, str_break # coloca {str_break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t1, a2, 0 # reinicia o contador em t1 (contador das quebras de linha)
	
	j p_loop # desvia para {p_loop}
p_end:
	ret # retorna
	
# funcao max -> acha o maior valor da matriz
	
max:
	addi t0, zero, 1 # contador de numeros verificados (comeca em 1 porque antes de entrar no loop verificaremos um numero)
	
	addi t2, zero, 0 # armazena a linha do maior elemento (comeca em 0)
	addi t3, zero, 0 # armazena a coluna do maior elemento (comeca em 0)
	addi t4, zero, 0 # armazena a linha do elemento atual (comeca em 0)
	addi t5, zero, 0 # armazena a coluna do elemento atual (comeca em 0)
	
	lw s0, 0(a1) # coloca o primeiro elemento da lista em s0
	add t6, zero, s0 # define o primeiro numero como valor maximo e o coloca em t6
m_loop:
	bge t0, a3, m_end # desvia se t0 (contador dos numeros verificados) for maior ou igual a a3 (quantidade de elementos no vetor)
	
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4)
	lw s0, 0(a1) # coloca o proximo elemento da lista em s0
	
	addi t0, t0, 1 # decrementa o contador de numeros verificados
	addi t4, t4, 1 # incrementa o valor da linha atual em 1
	addi t5, t5, 1 # incrementa o valor da coluna atual em 1
	
	blt s0, t6, m_loop # desvia se s0 (numero lido) for menor que t6 (valor maximo armazenado)
	
	mv t6, s0 # move o valor de s0 (numero lido) para t6 (valor maximo armazenado)
	mv t2, t4 # move o valor de t4 (linha do elemento atual) para t2 (linha do maior elemento)
	mv t3, t5 # move o valor de t5 (coluna do elemento atual) para t3 (coluna do maior elemento)
	
	j m_loop # desvia para {m_loop}
m_end:
	la a0, str_max # coloca o {str_max} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	add a0, zero, t6 # coloca em a0 o conteudo de t6 (o maior elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	ret # retorna
	
# funcao end -> encerra o programa

end:
	li a7, 10 # coloca o valor 10 em a7 (10 = finalizar programa)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)