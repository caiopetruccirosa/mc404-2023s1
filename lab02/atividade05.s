main:
    # Le o primeiro numero e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0
    beq s0, zero, fim

    # Le o segundo numero e armazena em s1
    addi t0, zero, 4
    ecall
    add s1, zero, a0
    beq s1, zero, fim

    # Armazena o maior numero em s2
    blt s0, s1, segundo_eh_maior
    add s2, zero, s0
    j imprime_maior
segundo_eh_maior:
    add s2, zero, s1

    # Imprime o valor do maior numero
imprime_maior:
    add a0, zero, s2
    addi t0, zero, 1
    ecall

    # Volta para o inicio
    j main
fim:
    ret

