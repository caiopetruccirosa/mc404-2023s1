main:
    # Le um numero de 0 a 15 e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0
    
    # Se o numero for maior ou igual a 10 transforma no hexadecimal respectivo
    addi t0, zero, 10
    bge s0, t0, transforma_hexadecimal

    # Soma o caracter '0'
    addi s0, s0, 48
    j imprime_fim

transforma_hexadecimal:
    # Transforma o decimal na letra respectiva (s0 = s0 - 10 + 65)
    addi s0, s0, 55

imprime_fim:
    # Imprime o numero hexadecimal
    add a0, zero, s0
    addi t0, zero, 2
    ecall

    # Imprime a letra 'h'
    addi a0, zero, 104
    addi t0, zero, 2
    ecall

    # Imprime o caracter de quebra de linha
    addi a0, zero, 10
    addi t0, zero, 2
    ecall

    ret