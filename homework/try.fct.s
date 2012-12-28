main:
    li      $a0, 4
    jal     factorial
    move    $a0, $v0
    #output res
    li      $v0, 1
    syscall
    jal      $ra

factorial: 
	bgtz $a0, doit 	# if $a0>0 goto generic case
	li $v0, 1 		# base case, 0! = 1 
	jr $ra 		# return 

doit: 
    sub $sp,8 		# make room for $s0 and $ra
	sw $s0,($sp) 	# store argument $s0=n
	sw $ra,4($sp) 	# store return address
	move $s0, $a0 	# save argument 
	sub $a0, 1 		#    factorial(n-1) 
	jal factorial 	#    v0 = (n-1)! 
	mul $v0,$s0,$v0 	# n*(n-1)! 
	lw $s0,($sp) 	# restore $s0=n
	lw $ra,4($sp) 	# restore $ra
	add $sp,8 		# reduce stack size
	jr $ra		# return 
