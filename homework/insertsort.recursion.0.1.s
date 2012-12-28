#------------------------------------------
#   Chunwei Yan     2012/10/19
#------------------------------------------
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

    .text
main:
    la      $t6, array           # $t6 <- array
    li      $s7, 1               #$s7   pointer
    jal     sort_each

sort_each:
    la      $s1, datas_1         #address of datas
    jal     data_trans
    jr      $ra

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
    j       insert_sort#else insert_sort

data_trans:
    addu    $t2, $s1, $t0       #get tem index of datas
    lb      $a0, 0($t2)
    addi    $a0, $a0, -48       #trans ascii to int
                                #a0, the data
    addu    $t2, $t6, $t0       #get arr element address
    sb      $a0, 0($t2)         #save int to array
    addi    $t0, $t0, 1         #i++
    j       loop
#------------------ end insert data ----------------
insert_sort: #<<<<<< begin insert_sort <<<<<<<<<<<
    la      $s1, array          # $s1 <- array
    move    $t0, $a0
    blt     $t0, 2, fit_base    #if n<2 do fit_base
    sw      $t0, 20($sp)        #save n
    sw      $t1, 16($fp)        #save f(n-1)



    
