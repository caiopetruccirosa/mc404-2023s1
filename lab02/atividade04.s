main:
    # Inicia o contador em s0 com valor 0
    add s0, zero, zero
    addi s1, zero, 10

loop:
    # Verifica se o contador eh maior ou igual a 10
    bge s0, s1, fim

    # Le um numero do teclado e armazena em a0
    addi t0, zero, 4
    ecall

    # Armazena a0 em s2 e soma 2 ao valor
    addi s2, a0, 2

    # Imprima o valor de a0 na tela
    add a0, zero, s2
    addi t0, zero, 1
    ecall

    # Incrementa o contador
    addi s0, s0, 1

    # Volta para o inicio
    j loop
fim:
    ret

