# PADRÃO DOS REGISTRADORES

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
str_here:  
	.string "Here: "

	.text
	
main:
	la a1, wrd_numbers # coloca o {wrd_numbers} em a1
	call input # chama a funcao {input}
	call reset # chama a funcao {reset}
	call print # chama a funcao {print}
	call reset # chama a funcao {reset}
	call maxNumber # chama a funcao {maxNumber}
	call end # chama a funcao {end}
	
# funcao para imprimir a matriz

print:
	addi t0, a3, 0 # contador do tamanho da matriz (t0 recebe o numero de elementos da matriz)
	addi t1, a2, 0 # contador das quebras de linha (t1 recebe o tamanho da linha da matriz)
p_loop:
	beq t1, zero, p_break # desvia se t1 (contador das quebras de linha) for igual a 0
	bge zero, t0, p_end # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	
	lw a0, 0(a1) # coloca em a0 o conteudo de a1 (o primeiro elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	la a0, str_space # coloca o {space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4)
	
	addi t0, t0, -1 # decrementa o contador do tamanho da matriz
	addi t1, t1, -1 # decrementa o contador das quebras de linha

	j p_loop # desvia para {p_loop}
p_break:
	la a0, str_break # coloca {break} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t1, a2, 0 # reinicia o contador em t1 (contador das quebras de linha)
	
	j p_loop # desvia para {p_loop}
p_end:
	ret # retorna
	
# funcao para ler os valores da matriz
	
input:
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_size # coloca o {str_size} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)
	
	addi t0, zero, 7 # coloca o valor 7 em t0 (para um tamanho máximo da matriz igual a 6)
	addi t1, zero, 2 # coloca o valor 2 em t1 (para um tamanho máximo da matriz igual a 2)
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
	
# funcao para retornar o ponteiro da matriz para o inicio
	
reset:
	addi t0, a3, 0 # coloca em t0 (contador do retorno do ponteiro) o tamanho da matriz
	
r_loop:
	bge zero, t0, r_end # desvia se t0 (contador do retorno do ponteiro) for menor ou igual a zero ("maior ou igual" invertido)
	
	addi a1, a1, -4 # retorna o ponteiro
	addi t0, t0, -1 # decrementa o contador
	
	j r_loop # desvia para {r_loop}
r_end:
	ret # retorna
	
maxNumber:  #NÃO EST�? FUNCIONANDO??????????????????????/
	addi t0, zero, 1 #the number of items it has passed
	addi t2, zero, 0 #puts zero on t2 -> line -> of the Max
	addi t3, zero, 0 #puts zero on t3 -> column -> of the Max
	addi t4, zero, 0 #puts zero on t4 -> line -> current one
	addi t5, zero, 0 #puts zero on t5 -> column -> current one
	lw s0, 0(a1) # puts in s0 the contents of a1 - the first element in the list
	add t6, zero, s0 #puts the max number on t6
	addi a1, a1, 4 #goes through the vector
	
loopMaxNumber:
	bgt t0, a3, endMaxNumber # branch if t0 (counter of matriz size) is grester than the entire size of the vector
	lw s0, 0(a1)
	addi a1, a1, 4 # goes through teh vector
	addi t0, t0, 1 # decrements counter
	addi t4, t4, 1 #increments current line
	addi t5, t5, 1 #increments current column
	
#	li a7, 1 # 1 = print int
#	ecall
	
	blt s0, t6, loopMaxNumber #branch if the number read is less than the one on t6
	
	mv t6, s0
	mv t2, t4
	mv t3, t5
	
	j loopMaxNumber
	
endMaxNumber:
	add a0, zero, t6
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que est� em a7)
	ret # retorna
	
end:
	li a7, 10 # coloca o valor 10 em a7 (10 = finalizar programa)
	ecall # faz a chamada de sistema (usando sempre o valor que esta em a7)