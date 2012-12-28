#Registers used:
#   $a0: parameter, initally n
#   $s0: placeholder for parameter n
#   $s1: fib(n-1)
#   $s2: fib(n-2)

    .text
main:       ## top module
    li      $v0, 5
    syscall
    move    $a0, $v0            # move the number read into $t0
    jal     fib

    move    $a0, $v0            # move the number read into $t0
    li      $v0, 1
    syscall

    jr      $ra



fib:
    ## Part1. Preample as a callee
    subu    $sp, $sp, 32        # create its stack frame
    sw      $ra, 28($sp)        # save the return address
    sw      $fp, 24($sp)        # save $fp of caller
    sw      $s0, 20($sp)        # callee saved registers
    sw      $s1, 16($sp)        # callee saved registers
    sw      $s2, 12($sp)
    addu    $fp, $sp, 32        # move $fp to the frame base

    ## Part2. main computation
    move    $s0, $a0            # get n from the caller
    blt     $s0, 2, fib_base    # if n<2 do the fib_base

    sub     $a0, $s0, 1         # compute fib(n-1)
    jal     fib
    move    $s1, $v0            # s1 = fib(n-1)

    sub     $a0, $s0, 2         # compute fib(n-2)
    jal     fib
    move    $s2, $v0            # s2 = fib(n-2)

    add     $v0, $s1, $s2       # v0 = fib(n-1) + fib(n-2)
    b       fib_ret

fib_base:
    li      $v0, 1

    ## Part3
fib_ret:
    lw      $ra, 28($sp)        # restore the return address
    lw      $fp, 24($sp)        # restore $fp to caller's frame pointer
    lw      $s0, 20($sp)        # restore $s0
    lw      $s1, 16($sp)        # restore $s1
    lw      $s2, 12($sp)        # restore $s1
    addi    $sp, $sp, 32        # restore the stack pointer
    jr      $ra                 # return 


