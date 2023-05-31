.text:
main:
    addi s0, s1, 12
    addi s0, s1, -50
    slli s0, s1, 12
    slli ra, ra, 0b10110 # 0b10110 == -10
    xor s0, s1, s2
    jal ra, 40
    ret
    beq s0, s1, 40
    lw s0, 0(s1)
    sw s2  , 0(s1)
    mul s2, s1, s0
    lui s1, 5000
    li s0, 5000
    li s1, 0xDEADBEEF
    li a0, -0xDEADBEEF
    li fp, 0b11110010101111111001100110000000
    li t0, -4090
    li t0, -2000
