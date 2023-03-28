main:
    # Le um caracter
    addi t0, zero, 5
    ecall
    add s0, zero, a0

    # Transforma o caracter em minusculo
    ori s0, s0, 32

    # Imprime um caracter
    add a0, zero, s0
    addi t0, zero, 2
    ecall

    ret