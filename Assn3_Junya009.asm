# Test program to implement the Russian Peasant multiplication algorithm
#  prompt for the input of two positive integers.
#  addition and doubling (multiplication by two). 
# 
# output:
#     Print the result 
#     Put the result into $s0 at completion of the routine.
#
# Junya Zhao   #############################################
# 03/02/2018   #############################################


.data
msg1: .asciiz "Please input an integer: "
msg2: .asciiz "The status of that input is "
msg3: .asciiz "Result : "


.text

la $a0, msg1 # load address 
addi $v0, $zero, 51  # Syscall to display message and parse input as int
syscall   # $a1 has status, $a0 has data (if valid)
add $t0, $zero, $a0  # preserve data

la $a0, msg1
addi $v0, $zero, 51  # Syscall to display message and parse input as int
syscall   # $a1 has status, $a0 has data (if valid)
add $t1, $zero, $a0  # preserve data

addi $t2, $zero, 1 # add 1 and $zero and put it into register $t2

loop: beq $t1, $t2, result
      andi $t3, $t1, 1
      beq $t3, $zero, after 
      add $s0, $s0, $t0
      sll $t0, $t0, 1 # doubling
      srl $t1, $t1, 1 # divide
      
      j loop  #jump back to the loop
      
after: srl $t1, $t1, 1 #( doubling) Shifts a register value right by 1 and places the value in the register $t1
       sll $t0, $t0, 1 # (divide) Shifts a register value left by 1 and places the value in the register $t0 
       j loop
       
result: add $s0, $s0, $t0
      la $a0, msg3 # load address 
      add $a1, $zero, $s0  # The integer returned from the original syscall
      addi $v0, $zero, 56  # Syscall to display message and parse an integer
      syscall