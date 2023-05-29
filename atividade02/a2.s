.text:
main:
    addi s0, s1, 12
    slli s0, s1, 12
    xor s0, s1, s2
    call destino
    ret
    beq s0, s1, 0x123
    lw s0, 0(s1)
    sw s2, 0(s1)
    mul s2, s1, s0
    lui s1, 5000
    li s0, 5000