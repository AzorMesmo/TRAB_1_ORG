	.data

wrd_numbers:
	.word	1,2,3,4,5,6,7,8,9
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
	call inputMatrix # chama a função {inputMatrix}
	call returnFirstAddress # chama a função {returnFirstAddress}
	call print # chama a função {print}
	call returnFirstAddress # chama a função {returnFirstAddress}
	call maxNumber # chama a função {maxNumber}
	li a7, 10 # coloca o valor 10 em a7 (10 = finalizar programa)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	
# função para imprimir a matriz
				
print:
	addi t1, a2, -1 # contador das quebras de linha (começa em 2 pois já imprimimos um número)
	addi t0, a3, -1 # contador do tamanho da matriz (começa em 8 pois já imprimimos um número)
	lw a0, 0(a1) # coloca em a0 o conteudo de a1 (o primeiro elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	la a0, str_space # coloca o {space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	
loopP:
	beq t1, zero, breakP # desvia se t1 (contador das quebras de linha) for igual a 0
	bge zero, t0, endP # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4)
	lw a0, 0(a1) # coloca em a0 o conteudo de a1 (o próximo elemento da lista) 
	li a7, 1 # coloca o valor 1 em a7 (1 = imprimir inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	addi t0, t0, -1 # decrementa o contador do tamanho da matriz
	addi t1, t1, -1 # decrementa o contador das quebras de linha
	la a0, str_space # coloca o {space} em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	j loopP # desvia para {loopP}
	
breakP:
	la a0, str_break # coloca break em a0
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	addi t1, t1, 3 # reinicia o contador em t1 (contador das quebras de linha)
	j loopP # desvia para {loopP}
	
endP:
	ret # retorna
	
# função para ler os valores da matriz
	
inputMatrix:
	j inputSize # desvia para {inputSize}
	
readMatrix:
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_number # coloca {str_number} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	sw a0, 0(a1) # move o valor de a0 para a1
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_break # coloca o {str_break} em a0
	addi t0, a3, -1 # contador do tamanho da matriz (começa em [tamanho - 1] porque já lê-mos um número)
	
loopI:
	bge zero, t0, endI # desvia se t0 (contador do tamanho da matriz) for menor ou igual a 0 ("maior que" invertido)
	addi a1, a1, 4 # vai para o proximo valor de a1 (adicionando 4
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_number # coloca o {str_number} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	sw a0, 0(a1) # move o valor de a0 para a1
	addi t0, t0, -1 # decrementa o contador
	j loopI # desvia para {loopI}
	
endI:
	ret # retorna
	
inputSize:
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_size # coloca o {str_size} em a0
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	li a7, 5 # coloca o valor 5 em a7 (5 = ler inteiro)
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	addi t0, zero, 7
	addi t1, zero, 1
	blt a0, t1, endI # desvia se a0 for menor que t1 [NÃO FUNCIONA SE SIZE < 2]
	bge a0, t0, endI # desvia se a0 for maior ou igual a t0
	mul a3, a0, a0 # multiplica o tamanho por ele mesmo para obter o número de elementos da matriz e coloca em a3
	mv a2, a0 # move a0 (tamanho) para a2
	li a7, 4 # coloca o valor 4 em a7 (4 = imprimir string)
	la a0, str_break
	j readMatrix
	
returnFirstAddress:
	addi t0, a3, -1   # counter of matriz size (starts on entire size - 1)
	
loopO:
	bge zero, t0, endO # branch if t0 (counter of matriz size) less or equal to 0 (inverted statement)
	addi a1, a1, -4 # goes through the vector
	addi t0, t0, -1 # decrements counter
	
	j loopO # jump to loopI label
	
endO:
	ret # retorna
	
maxNumber:  #NÃƒO ESTÃ? FUNCIONANDO??????????????????????/
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
	ecall # faz a chamada de sistema (usando sempre o valor que está em a7)
	ret # retorna
	
