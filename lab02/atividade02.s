main:
    # Le um numero do teclado e armazena em a0
    addi t0, zero, 4
    ecall

    # Armazena a0 em s0
    add s0, zero, a0

    # Soma 2 ao valor de s0 e armazena o resultado em a0
    addi a0, s0, 2

    # Imprima o valor de a0 na tela
    addi t0, zero, 1
    ecall

    # Se o valor lido for igual a zero, va para o fim
    beq s0, zero, fim

    # Volta para o inicio
    j main
fim:
    ret

