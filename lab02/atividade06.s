main:
    # le um numero do teclado e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0

    # le um numero do teclado e armazena em s1
    addi t0, zero, 4
    ecall
    add s1, zero, a0

    # faz a subtracao: s2 = s0 - s1
    sub s2, s0, s1

    bge s2, zero, imprime_numero

    # torna o numero em s2 positivo
    sub s2, zero, s2

    # imprime o sinal de menos e o numero transformado em positivo
    addi a0, zero, 45
    addi t0, zero, 2
    ecall

imprime_numero:
    add a0, zero, s2
    addi t0, zero, 1
    ecall

    ret
