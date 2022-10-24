	.data

numbs:	.word	1,2,3,4,5,6,7,8,9
size:	.word	3
space:	.string	" "
break:	.string "\n"

	.text
	
main:
	la a1, numbs # set numbs to a1
	lw a2, size # set size to a1
	call print # call print funcion
	li a7, 10 # 10 = end program
	ecall # do the system call
	
print:
	addi t1, zero, 2 # counter of breaks (stars on 2 because we've already printed one number)
	addi t0, zero, 8 # counter of matriz size (starts on 8 because we've already printed one number)
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
