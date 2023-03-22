main:
    # Le um numero do teclado e armazena em s0
    addi t0, zero, 4
    ecall
    add s0, zero, a0

    # Verifica se o numero em s0 eh multiplo de 4 e armazena em s1
    # Se s1 == 0 entao eh multiplo de 4 senao nao eh
    andi s1, s0, 3

    # Se for multiplo, armazena letra S em s2
    beq s1, zero, eh_multiplo

    # Armazena a letra N em s2
    addi s2, zero, 78
    j imprime_letra

    # Armazena a letra S em s2
eh_multiplo:
    addi s2, zero, 83

    # Imprime a letra respectiva, S ou N, na saida
imprime_letra:
    addi t0, zero, 2
    add a0, zero, s2
    ecall

    ret