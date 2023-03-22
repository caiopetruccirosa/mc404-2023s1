main:
    # Le um numero do teclado e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0

    # Verifica se o numero em s0 eh impar e armazena em 
    andi s1, s0, 1

    # Se for par, armazena letra P em t0
    beq s1, zero, eh_par

    # Armazena a letra I em s2
    addi s2, zero, 73
    j imprime_letra

    # Armazena a letra P em s2
eh_par:
    addi s2, zero, 80

    # Imprime a letra respectiva, P ou I, na saida
imprime_letra:
    addi t0, zero, 2
    add a0, zero, s2
    ecall

    ret