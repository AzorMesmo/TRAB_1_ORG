	.data

numbs:	.word	1,2,3,4,5,6,7,8,9
space:	.string	" "
break:	.string "\n"
inputN: .string "Number: "
inputS: .string "Size: "
here:   .string "Here: "

	.text
	
main:
	la a1, numbs # set numbs to a1
	call inputMatrix
	call returnFirstAddress
	call print # call print funcion
	call returnFirstAddress
	call maxNumber
	li a7, 10 # 10 = end program
	ecall # do the system call
	
	
print:
	addi t1, a2, -1 # counter of breaks (stars on 2 because we've already printed one number)
	addi t0, a3, -1 # counter of matriz size (starts on 8 because we've already printed one number)
	lw a0, 0(a1) # puts in a0 the contents of a1 - the first element in the list 
	li a7, 1 # 1 = print int
	ecall
	la a0, space # set space to a0
	li a7, 4
	ecall
	
loopP:
	beq t1, zero, breakP # branch if t1 (counter of breaks) is equal 0
	bge zero, t0, endP # branch if t0 (counter of matriz size) less or equal to 0 (inverted statement)
	addi a1, a1, 4 # goes through teh vector
	lw a0, 0(a1)
	li a7, 1
	ecall
	addi t0, t0, -1 # decrements counter
	addi t1, t1, -1 # decrements counter
	la a0, space
	li a7, 4
	ecall
	j loopP # jump to loopP label
	
breakP:
	la a0, break # set break to a0
	li a7, 4
	ecall
	addi t1, t1, 3 # reset the counter in t1 (counter of breaks)
	j loopP
	
	
endP:
	ret # return
	
inputMatrix:
	j inputSize #reads size
readMatrix:
	li a7, 4
	la a0, inputN #prints "Number: "
	ecall
	
	li a7, 5 #reads first number
	ecall
	sw a0, 0(a1) #moves number to register a1
	
	li a7, 4
	la a0, break #new line
	
	addi t0, a3, -1   # counter of matriz size (starts on (entire size - 1) because we've already read one number)
loopI:
	bge zero, t0, endI # branch if t0 (counter of matriz size) less or equal to 0 (inverted statement)
	addi a1, a1, 4 # goes through teh vector
	
	li a7, 4
	la a0, inputN #prints "Number: "
	ecall
	
	li a7, 5 #reads number
	ecall
	sw a0, 0(a1) #moves number to register a1
	
	addi t0, t0, -1 # decrements counter
	
	j loopI # jump to loopI label
	
endI:
	ret # return
	
inputSize:
	li a7, 4
	la a0, inputS #prints "Size: "
	ecall
	
	li a7, 5 #reads size
	ecall
	
	addi t0, zero, 7
	addi t1, zero, 1
	
	blt a0, t1, endI #NÃO ESTÁ VOLTANDO SE O SIZE É MENOR QUE 2????????????????????????????????
	bge a0, t0, endI #returns if the size is greater than 6
	
	mul a3, a0, a0 #multiples the size to have the complete number and puts it on a3
	mv a2, a0 #moves size to register a2
	
	li a7, 4
	la a0, break #new line
	
	j readMatrix
	
returnFirstAddress:
	addi t0, a3, -1   # counter of matriz size (starts on entire size - 1)
loopO:
	bge zero, t0, endO # branch if t0 (counter of matriz size) less or equal to 0 (inverted statement)
	addi a1, a1, -4 # goes through the vector
	addi t0, t0, -1 # decrements counter
	
	j loopO # jump to loopI label
endO:
	ret #return
	
	
	
maxNumber:  #NÃO ESTÁ FUNCIONANDO??????????????????????/
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
	li a7, 1
	ecall
	ret # return
	