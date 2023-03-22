main:
    # Le o numero segredo do teclado e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0

    # Le o numero a codificar ou decodificar do teclado e armazena em s1
    addi t0, zero, 4
    ecall
    add s1, zero, a0

    # Codifica ou decodifica o numero e armazena o resultado em s3
    xor s3, s0, s1

    # Imprime a codificacao ou decodificacao em s3
    add a0, zero, s3
    addi t0, zero, 1
    ecall

    ret