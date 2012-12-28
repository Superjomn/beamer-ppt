    .data
array:.space 1024
address:.space 512
datas_1:.asciiz "3745809621"
datas_2:.asciiz "0123456789"
datas_3:.asciiz "9876543210"
trying_to_sort_message:.asciiz "\ntrying to sort: "
split_message:.asciiz "\n"
begin_assign_data_message:.asciiz "\n>begin to trans ascii string to int array\n"
begin_sort_message:.asciiz "\n>begin to sort\n"
end_message:.asciiz "\n>end....\n"
in_insert_message:.asciiz "\n>in insert\n"

    .text
main:
#   used registers:
#   $s4     1

    #---- parse ascii string to int array ----
    #---- three circles
    la      $t6, array           # $t6 <- array
    li      $s7, 1               #$s7   pointer

sort_each:
    li      $t3, 1
    beq     $s7, $t3, sort1
    li      $t3, 2
    beq     $s7, $t3, sort2
    li      $t3, 3
    beq     $s7, $t3, sort3
    jal     $ra

sort1:
    la      $s1, datas_1         #address of datas
    addi    $s7, $s7, 1
    j       input_data
sort2:
    la      $s1, datas_2         #address of datas
    addi    $s7, $s7, 1
    j       input_data
sort3:
    la      $s1, datas_3         #address of datas
    addi    $s7, $s7, 1
    j       input_data
    jal     $ra


input_data: #<<<<<< begin input data to array <<<<<<<<
#   used registers
#   $s1     address of ascii string
#   $t0     i
#   $t1     N
#   $t2     tem address
    li      $t1, 10              # N
    li      $t0, 0               # i
    li      $t2, 0               #tem address
    #show   trying_to_sort_message
    la      $a0, trying_to_sort_message
    jal     output_string
    move    $a0, $s1            #show datas to sort
    jal     output_string
    la      $a0, split_message
    jal     output_string

    # output message
    la      $a0, begin_assign_data_message
    jal     output_string

loop:
    bne     $t0, $t1, data_trans#i<N loop
    # output message
    la      $a0, begin_sort_message
    jal     output_string
    la      $s1, array
    li      $a0, 10
    jal     insert_sort#else insert_sort
    jr      $ra

data_trans:
    addu    $t2, $s1, $t0       #get tem index of datas
    lb      $a0, 0($t2)
    addi    $a0, $a0, -48       #trans ascii to int
                                #a0, the data
    addu    $t2, $t6, $t0       #get arr element address
    sb      $a0, 0($t2)         #save int to array
    addi    $t0, $t0, 1         #i++
    jal     loop
#------------------ end insert data ----------------

insert_sort:
# used  registers:
#   $a0     n
#   *$t1     n
    bgtz    $a0, doit           # if n>0 goto doit
    li      $v0, 1
    jal     output              # else return
    jr      $ra

doit:
    subu     $sp, $sp, 8              # make room for $s0 $ra
	sw      $s0, ($sp) 	        # store argument $s0=n
	sw      $ra, 4($sp) 	    # store return address
	move    $s0, $a0 	        # save argument 
	sub     $a0, 1 		        # InsertionSort (n-1) 

    jal     insert_sort

    # main compute
    move    $t1, $s0            # $t1 : n
    addi    $t0, $s0, -1        # $t0 : i = n-1
    j       insert              # Insert($t1)

doit_rst:
    lw      $s0, ($sp)
    lw      $ra, 4($sp)
    add     $sp, 8
    jr      $ra

insert:
#   used    registers:
#   $t0     i
#   $t3     tem
    la      $a0, in_insert_message
    jal     output_string
    addu    $t3, $s1, $t1       # key address
    lb      $t3, 0($t3)         # 
    move    $s3, $t3            # $s3 : key = a[n]

insert_loop:
    li      $t2, -1             # if i($t0)==-1 return
    beq     $t0, $t2, insert_ret
    addu    $t3, $s1, $t0       # a[i] address
    lb      $t3, 0($t3)         # get a[i]
    move    $t4, $t3            # $t4 : a[i]
    slt     $t2, $s3, $t3       
    li      $t3, 0
    beq     $t2, $t3, insert_ret

    addu    $t3, $s1, $t0       # $t3 = a[i] address
    addi    $t3, $t3, 1
    sb      $t4, 0($t3)         # a[i+1] = a[i]`
    addi    $t0, $t0, -1        # i--
    j       insert_loop         # while loop

insert_ret:
    addi    $t3, $t0, 1
    addu    $t3, $s1, $t3       # a[i+1] address
    sb      $s3, 0($t3)         # a[i+1] = key
    j       doit_rst            #return
    

output:                         #output array
    li      $t0, 0              #i

output_loop:
    beq     $t0, $t2, end       #if i==N end 
    addu    $s2, $s1, $t0       #tem index address
    #output
    lb      $a0, 0($s2)
    li      $v0, 1
    syscall

    addi    $t0, $t0, 1
    j       output_loop

end:
    la      $a0, end_message
    jal     output_string
    jr      $ra 

output_string:  #<<<<<<< function <<<<<<<<
    li      $v0, 4
    syscall
    jr      $ra

