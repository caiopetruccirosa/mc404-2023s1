main:
    # Le um numero do teclado e armazena em s0
    # addi t0, zero, 4
    # ecall
    # add s0, zero, a0
    addi s0, zero, 9865

    # Inicia um contador em s1 para realizar 8 iteracoes (decrementa o contador de 4 em 4)
    addi s1, zero, 28

loop:
    # Encerra o loop quando termina as iteracoes
    blt s1, zero, fim_loop

    # Armazena em s2 os 4 bits processados na iteracao atual
    srl s2, s0, s1
    andi s2, s2, 15

    # Se o numero for maior ou igual a 10 transforma no hexadecimal respectivo
    addi t0, zero, 10
    bge s2, t0, transforma_hexadecimal

    # Soma o caracter '0' caso numero seja menor que 10
    addi s2, s2, 48

    j imprime_digito

transforma_hexadecimal:
    # Transforma o decimal na letra respectiva (s2 = s2 - 10 + 65)
    addi s2, s2, 55

imprime_digito:
    # Imprime o digito hexadecimal armazenado no s2
    add a0, zero, s2
    addi t0, zero, 2
    ecall

    # Decrementa o contador e inicia proxima iteracao do loop
    addi s1, s1, -4
    j loop

fim_loop:
    # Imprime a letra 'h'
    addi a0, zero, 104
    addi t0, zero, 2
    ecall

    # Imprime o caracter de quebra de linha
    addi a0, zero, 10
    addi t0, zero, 2
    ecall

    ret